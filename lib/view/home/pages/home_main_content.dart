import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/common_widgets/price_widget.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';
import 'package:simple_nav_bar/controllers/product_controller/post_details_controller.dart';
import 'package:simple_nav_bar/services/user_service/user_service_impl.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/categories/models/category.dart';
import 'package:simple_nav_bar/view/home/pages/post_details.dart';
import 'package:simple_nav_bar/view/home/widgets/announce_en_vedette.dart';
import 'package:simple_nav_bar/view/home/widgets/announce_populaire.dart';
import 'package:simple_nav_bar/view/home/widgets/announce_recommande.dart';
import 'package:simple_nav_bar/view/home/widgets/hoverable_category_item_widget.dart';
import 'package:simple_nav_bar/view/home/widgets/widget_components.dart';

class HomeMainContent extends StatefulWidget {
  final ScrollController scrollController, scrollController1, scrollController2;
  final double width, height;
  final double itemWidthWithSpacing;
  final int currentStartIndex;
  final int currentStartIndex1;
  final int currentPage;
  final int currentPage1;
  final int currentPage2;

  const HomeMainContent({
    super.key,
    required this.scrollController,
    required this.scrollController1,
    required this.scrollController2,
    required this.width,
    required this.height,
    required this.currentPage2,
    required this.itemWidthWithSpacing,
    required this.currentStartIndex,
    required this.currentStartIndex1,
    required this.currentPage,
    required this.currentPage1,
  });

  @override
  State<HomeMainContent> createState() => _HomeMainContentState();
}

class _HomeMainContentState extends State<HomeMainContent> {
  late ScrollController scrollController, scrollController1, scrollController2;
  late double width, height;
  late int currentPage;
  late int currentPage1;
  late int currentPage2;
  late double itemWidthWithSpacing;
  late int currentStartIndex;
  late int currentStartIndex1;

  //final profileController = Get.find<ProfileController>();
  final userService = Get.put<UserServiceImpl>(UserServiceImpl());
  final postController = Get.put(PostController());
  final homeController = Get.find<HomeController>();
  var categoryController = Get.find<CategoryContorller>();
  final postDetailsController = Get.find<PosttDetailsController>();

  @override
  void initState() {
    scrollController = widget.scrollController;
    scrollController1 = widget.scrollController1;
    scrollController2 = widget.scrollController2;
    width = widget.width;
    height = widget.height;
    currentPage2 = widget.currentPage2;
    itemWidthWithSpacing = widget.itemWidthWithSpacing;
    currentStartIndex = widget.currentStartIndex;
    currentStartIndex1 = widget.currentStartIndex1;
    currentPage = widget.currentPage;
    currentPage1 = widget.currentPage1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isFeaturedPostsloading =
          homeController.fakeFeaturedPostsloading.value ||
          homeController.featuredPostsloading.value;
      final isTrendingPostsLoading =
          homeController.fakeTrendingPostsloading.value ||
          homeController.trendingPostsloading.value;
      final isSuggestedPostsLoading =
          homeController.suggestedPostsloading.value ||
          homeController.fakeSuggestedPostsloading.value;
      return Positioned.fill(
        child: ListView(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 165),
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: mainMargin),
              height: 170.h,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF4EDF8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Vendez, Achetez, Simplifiez votre vie!',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton.icon(
                    onPressed: () {
                      //homeController.getFeaturedPosts();
                    },
                    icon: Icon(LucideIcons.camera, color: whiteColor),
                    label: Text(
                      'Déposer une annonce',
                      style: GoogleFonts.poppins(
                        color: whiteColor,
                        fontSize: 12,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blueColor,
                      shape: StadiumBorder(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: mainMargin),
              height: 80, // Optional: define a height for better layout control
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                    categoryController.categories1.isEmpty
                        ? Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.sizeOf(context).width / 3.5,
                          ),
                          child: Center(child: Text("chargement en cours...")),
                        )
                        : Row(
                          children:
                              categoryController.categories1.map((cat) {
                                final categoryIcon =
                                    iconsMap[cat.name] ??
                                    CategoryIcon(
                                      LucideIcons.helpCircle,
                                      Colors.black,
                                    );

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                  ),
                                  child: HoverableCategoryItem(
                                    icon: categoryIcon.icon,
                                    label: cat.name!,
                                    color: categoryIcon.color,
                                    onTap: () async {
                                      homeController.homeIndex.value = 1;
                                      categoryController
                                          .selectedCategoryName
                                          .value = cat.name!;
                                      if (categoryController
                                              .selectedCategoryName
                                              .value ==
                                          "Tous") {
                                        await postController
                                            .getAllPostsByStatus(status: "all");
                                      } else {
                                        categoryController
                                            .selectedCategoryId
                                            .value = cat.id!;
                                        await postController
                                            .getPostsByCategoryNameorId(
                                              categoryId: cat.id!,
                                            );
                                      }
                                    },
                                  ),
                                );
                              }).toList(),
                        ),
              ),
            ),
            SizedBox(height: 12.h),
            SectionHeader(
              " Meilleures annonces en \n vedette",
              title2: "vedette",
            ),
            SizedBox(height: 12.h),
            AnnounceEnVedette(
              height: height,
              width: width,
              homeController: homeController,
              postController: postController,
              postDetailsController: postDetailsController,
              scrollController2: scrollController2,
              isLoading: isFeaturedPostsloading,
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  homeController.featuredPosts.length -
                      (homeController.featuredPosts.length - 3),
                  (i) => InkWell(
                    onTap: () {
                      setState(() {
                        currentPage2 = i;
                        scrollController2.animateTo(
                          i * itemWidthWithSpacing,
                          duration: Duration(milliseconds: 100),
                          curve: Curves.linear,
                        );
                      });
                    },
                    child: Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            currentPage2 == i
                                ? Colors.yellow.shade900
                                : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            SectionHeader(" Nos annonces\n recommandées",title2: "recommandees",),
            AnnounceRecommande(
              isLoading: isSuggestedPostsLoading,
              scrollController1: scrollController1,
              homeController: homeController,
              postController: postController,
              postDetailsController: postDetailsController,
              controller: scrollController1,
              width: width,
              height: height,
              currentPage: currentPage,
              currentPage1: currentPage1,
            ),
            const SizedBox(height: 20),

            SectionHeader(" Annonces tendances\n populaires",title2: "populaires",),

            AnnouncePopulaire(
              isLoading: isTrendingPostsLoading,
              scrollController1: scrollController,
              homeController: homeController,
              postController: postController,
              postDetailsController: postDetailsController,
              controller: scrollController,
              width: width,
              height: height,
              currentPage: currentPage,
              currentPage1: currentPage1,
            ),
            const SizedBox(height: 20),
            footerSections(),
            //const SizedBox(height: 25),
          ],
        ),
      );
    });
  }
}
