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
            sectionHeader(
              " Meilleures annonces en \n vedette",
              title2: "vedette",
            ),
            SizedBox(height: 12.h),

            homeController.fakeFeaturedPostsloading.value
                ? Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColo1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: width * 0.32,
                  height: height * 0.25,
                  child: Center(
                    child: Text(
                      "Chargement en cours...",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                )
                : homeController.featuredPostsloading.value
                ? Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColo1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: width * 0.32,
                  height: height * 0.25,
                  child: Center(
                    child: Text(
                      "Chargement en cours...",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                )
                : Container(
                  margin: EdgeInsets.symmetric(horizontal: mainMargin),
                  height: height * 0.50,
                  child: ListView.builder(
                    controller: scrollController2,
                    scrollDirection: Axis.horizontal,
                    itemCount: homeController.featuredPosts.length,
                    itemBuilder: (context, index) {
                      //final ad = featuredAds[index];
                      final post = homeController.featuredPosts[index];
                      final user =
                          homeController.usersForfeaturedPosts[post.userId];

                      final isLiked = postController.isPostLiked(post.id!);

                      if (user == null) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: greyColo1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: width * 0.32,
                          height: height * 0.25,
                          child: Center(
                            child: CircularProgressIndicator(
                              constraints: BoxConstraints.tight(
                                Size.fromRadius(12.r),
                              ),
                              valueColor: AlwaysStoppedAnimation(primaryColor),
                            ),
                          ),
                        );
                      }
                      return Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: width * 0.32,
                        height: height * 0.25,
                        //margin: EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey[200],
                                    ),
                                    height: height * 0.25,
                                    width: width * 0.32,
                                    child: InkWell(
                                      onTap: () {
                                        postDetailsController.getUser(
                                          userId: post.userId!,
                                        );

                                        Get.to(
                                          () => PostDetails(),
                                          arguments: post,
                                        );
                                        postController.viewPost(
                                          postId: post.id!,
                                        );
                                      },
                                      child: Image.network(
                                        post.mediaUrls!.first.content == null
                                            ? 'https://cdn.pixabay.com/photo/2016/11/20/09/06/laptop-1842297_1280.jpg'
                                            : "${post.mediaUrls!.first.content}",
                                        height: height * 0.25,
                                        width: width * 0.32,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: InkWell(
                                    onTap: () {
                                      postController.toggleLike(post);
                                      setState(() {});
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          isLiked ? Colors.red : Colors.white,
                                      radius: 12,
                                      child: Icon(
                                        size: 18,
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color:
                                            isLiked ? Colors.white : Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              spacing: 5,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.yellow.shade900,
                                  radius: 12,
                                  child: Text(
                                    (user.name?.isNotEmpty ?? false)
                                        ? user.name![0].toUpperCase()
                                        : "U", // fallback initial
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  tooShortTruncateWithEllipsis(
                                    user.name ?? "No name",
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: blackColor2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              post.description!,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: blackColor2,
                                textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            PriceWidget(
                              price: post.price!.toString(),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: blackColor2,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              maxLines: 2,
                              post.location == null
                                  ? "N'Djamena /\nN'Djamena-Centre"
                                  : "",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: greyColor,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              formatShortDateNumber(
                                post.date!.toIso8601String(),
                              ),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: greyColor,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            /* Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100.withValues(alpha: .5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Livraison possible',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ), */
                          ],
                        ),
                      );
                    },
                  ),
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
            sectionHeader(
              " Nos annonces\n recommandées",
              title2: "recommandees",
            ),

            homeController.fakeSuggestedPostsloading.value
                ? Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColo1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: width * 0.45,
                  height: height * 0.25,
                  child: Center(
                    child: Text(
                      "Chargement en cours...",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                )
                : homeController.suggestedPostsloading.value
                ? Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColo1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: width * 0.45,
                  height: height * 0.25,
                  child: Center(
                    child: Text(
                      "Chargement en cours...",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                )
                : _horizontalGridForSuggestedPosts(
                  controller: scrollController1,
                ),
            const SizedBox(height: 20),
            sectionHeader(
              " Annonces tendances\n populaires",
              title2: "populaires",
            ),

            homeController.fakeTrendingPostsloading.value
                ? Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColo1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: width * 0.45,
                  height: height * 0.25,
                  child: Center(
                    child: Text(
                      "Chargement en cours...",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                )
                : homeController.trendingPostsloading.value
                ? Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColo1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: width * 0.45,
                  height: height * 0.25,
                  child: Center(
                    child: Text(
                      "Chargement en cours...",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                )
                : _horizontalGridForTrendingPosts(controller: scrollController),
            const SizedBox(height: 20),
            footerSections(),
            //const SizedBox(height: 25),
          ],
        ),
      );
    });
  }

  Widget _horizontalGridForTrendingPosts({required controller}) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    final double itemWidth = width * 0.45;
    final double spacing = 14.0;
    final double itemWidthWithSpacing = itemWidth + spacing;

    // Each page shows 2 items
    const int itemsPerPage = 2;

    int totalPages =
        (homeController.trendingPosts.length / itemsPerPage).ceil();

    int currentPageLocal =
        controller == scrollController1 ? currentPage1 : currentPage;

    final bool isFirstPage = currentPageLocal == 0;
    final bool isLastPage = currentPageLocal >= totalPages - 1;

    return SizedBox(
      height: height * 0.52,
      child: Stack(
        children: [
          SizedBox(
            height: height * 0.5,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: spacing),
              shrinkWrap: false,
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: homeController.trendingPosts.length,
              itemBuilder: (context, index) {
                final post = homeController.trendingPosts[index];
                final user = homeController.usersFortrendingPosts[post.userId];
                final isLiked = postController.isPostLiked(post.id!);

                if (user == null) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: greyColo1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: itemWidth,
                    height: height * 0.25,
                    child: Center(
                      child: CircularProgressIndicator(
                        constraints: BoxConstraints.tight(
                          Size.fromRadius(12.r),
                        ),
                        valueColor: AlwaysStoppedAnimation(primaryColor),
                      ),
                    ),
                  );
                }

                return Container(
                  padding: EdgeInsets.all(8),
                  width: itemWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: height * 0.25,
                              width: itemWidth,
                              color: Colors.grey[200],
                              child: InkWell(
                                onTap: () {
                                  postDetailsController.getUser(
                                    userId: post.userId!,
                                  );
                                  Get.to(() => PostDetails(), arguments: post);
                                  postController.viewPost(postId: post.id!);
                                },
                                child: Image.network(
                                  post.mediaUrls!.first.content ??
                                      'https://cdn.pixabay.com/photo/2016/11/20/09/06/laptop-1842297_1280.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            top: 8,
                            right: 8,
                            child: InkWell(
                              onTap: () {
                                postController.toggleLike(post);
                                setState(() {});
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    isLiked ? Colors.red : Colors.white,
                                radius: 12,
                                child: Icon(
                                  size: 18,
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked ? Colors.white : Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        //spacing: 5,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.yellow.shade900,
                            radius: 12,
                            child: Text(
                              (user.name?.isNotEmpty ?? false)
                                  ? user.name![0].toUpperCase()
                                  : "U",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            user.name!,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: blackColor2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        post.description!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: blackColor2,
                          textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      SizedBox(height: 8),
                      PriceWidget(
                        price: post.price!.toString(),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: blackColor2,
                      ),
                      SizedBox(height: 8),
                      Text(
                        post.location ?? "N'Djamena /\nN'Djamena-Centre",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: greyColor,
                        ),
                      ),
                      Text(
                        formatShortDateNumber(post.date!.toIso8601String()),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          /// 🔹 Forward & Backward buttons (page-based now)
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: mainMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: MediaQuery.sizeOf(context).width / 1.9,
                children: [
                  InkWell(
                    onTap:
                        isFirstPage
                            ? null
                            : () {
                              setState(() {
                                if (controller == scrollController1) {
                                  currentPage1--;
                                } else {
                                  currentPage--;
                                }
                              });
                              controller.animateTo(
                                (currentPageLocal - 1) *
                                    itemsPerPage *
                                    itemWidthWithSpacing,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                    child: CircleAvatar(
                      backgroundColor:
                          isFirstPage
                              ? greyColo1.withValues(alpha: 0.5)
                              : whiteColor,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 12,
                        color: greyColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap:
                        isLastPage
                            ? null
                            : () {
                              setState(() {
                                if (controller == scrollController1) {
                                  currentPage1++;
                                } else {
                                  currentPage++;
                                }
                              });
                              controller.animateTo(
                                (currentPageLocal + 1) *
                                    itemsPerPage *
                                    itemWidthWithSpacing,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                    child: CircleAvatar(
                      backgroundColor:
                          isLastPage
                              ? greyColo1.withValues(alpha: 0.5)
                              : whiteColor,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: greyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 Sliding Page Indicators
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Builder(
              builder: (context) {
                const int maxVisibleIndicators = 7;

                int startIndex;
                int endIndex;

                if (totalPages <= maxVisibleIndicators) {
                  startIndex = 0;
                  endIndex = totalPages;
                } else {
                  startIndex = (currentPageLocal - (maxVisibleIndicators ~/ 2))
                      .clamp(0, totalPages - maxVisibleIndicators);
                  endIndex = startIndex + maxVisibleIndicators;
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(endIndex - startIndex, (i) {
                    int actualIndex = startIndex + i;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (controller == scrollController1) {
                            currentPage1 = actualIndex;
                          } else {
                            currentPage = actualIndex;
                          }
                        });
                        controller.animateTo(
                          actualIndex * itemsPerPage * itemWidthWithSpacing,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: currentPageLocal == actualIndex ? 10 : 6,
                        height: currentPageLocal == actualIndex ? 10 : 6,
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              currentPageLocal == actualIndex
                                  ? Colors.yellow.shade900
                                  : Colors.grey.shade300,
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _horizontalGridForSuggestedPosts({required controller}) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    final double itemWidth = width * 0.45;
    final double spacing = 14.0;
    final double itemWidthWithSpacing = itemWidth + spacing;

    // Each page shows 2 items
    const int itemsPerPage = 2;

    int totalPages =
        (homeController.suggestedPosts.length / itemsPerPage).ceil();

    int currentPageLocal =
        controller == scrollController1 ? currentPage1 : currentPage;

    final bool isFirstPage = currentPageLocal == 0;
    final bool isLastPage = currentPageLocal >= totalPages - 1;

    return SizedBox(
      height: height * 0.52,
      child: Stack(
        children: [
          SizedBox(
            height: height * 0.5,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: spacing),
              shrinkWrap: false,
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: homeController.suggestedPosts.length,
              itemBuilder: (context, index) {
                final post = homeController.suggestedPosts[index];
                final user = homeController.usersForSuggestedPosts[post.userId];
                final isLiked = postController.isPostLiked(post.id!);

                if (user == null) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: greyColo1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: itemWidth,
                    height: height * 0.25,
                    child: Center(
                      child: CircularProgressIndicator(
                        constraints: BoxConstraints.tight(
                          Size.fromRadius(12.r),
                        ),
                        valueColor: AlwaysStoppedAnimation(primaryColor),
                      ),
                    ),
                  );
                }

                return Container(
                  padding: EdgeInsets.all(8),
                  width: itemWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: height * 0.25,
                              width: itemWidth,
                              color: Colors.grey[200],
                              child: InkWell(
                                onTap: () {
                                  postDetailsController.getUser(
                                    userId: post.userId!,
                                  );
                                  Get.to(() => PostDetails(), arguments: post);

                                  postController.viewPost(postId: post.id!);
                                },
                                child: Image.network(
                                  post.mediaUrls!.first.content ??
                                      'https://cdn.pixabay.com/photo/2016/11/20/09/06/laptop-1842297_1280.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            top: 8,
                            right: 8,
                            child: InkWell(
                              onTap: () {
                                postController.toggleLike(post);
                                setState(() {});
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    isLiked ? Colors.red : Colors.white,
                                radius: 12,
                                child: Icon(
                                  size: 18,
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked ? Colors.white : Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        //spacing: 5,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.yellow.shade900,
                            radius: 12,
                            child: Text(
                              (user.name?.isNotEmpty ?? false)
                                  ? user.name![0].toUpperCase()
                                  : "U",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            user.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: blackColor2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        post.description!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: blackColor2,
                          textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      SizedBox(height: 8),
                      PriceWidget(
                        price: post.price!.toString(),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: blackColor2,
                      ),
                      SizedBox(height: 8),
                      Text(
                        post.location ?? "N'Djamena /\nN'Djamena-Centre",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: greyColor,
                        ),
                      ),
                      Text(
                        formatShortDateNumber(post.date!.toIso8601String()),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          /// 🔹 Forward & Backward buttons (page-based now)
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: mainMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: MediaQuery.sizeOf(context).width / 1.9,
                children: [
                  InkWell(
                    onTap:
                        isFirstPage
                            ? null
                            : () {
                              setState(() {
                                if (controller == scrollController1) {
                                  currentPage1--;
                                } else {
                                  currentPage--;
                                }
                              });
                              controller.animateTo(
                                (currentPageLocal - 1) *
                                    itemsPerPage *
                                    itemWidthWithSpacing,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                    child: CircleAvatar(
                      backgroundColor:
                          isFirstPage
                              ? greyColo1.withValues(alpha: 0.5)
                              : whiteColor,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 12,
                        color: greyColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap:
                        isLastPage
                            ? null
                            : () {
                              setState(() {
                                if (controller == scrollController1) {
                                  currentPage1++;
                                } else {
                                  currentPage++;
                                }
                              });
                              controller.animateTo(
                                (currentPageLocal + 1) *
                                    itemsPerPage *
                                    itemWidthWithSpacing,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                    child: CircleAvatar(
                      backgroundColor:
                          isLastPage
                              ? greyColo1.withValues(alpha: 0.5)
                              : whiteColor,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: greyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 Sliding Page Indicators
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Builder(
              builder: (context) {
                const int maxVisibleIndicators = 7;

                int startIndex;
                int endIndex;

                if (totalPages <= maxVisibleIndicators) {
                  startIndex = 0;
                  endIndex = totalPages;
                } else {
                  startIndex = (currentPageLocal - (maxVisibleIndicators ~/ 2))
                      .clamp(0, totalPages - maxVisibleIndicators);
                  endIndex = startIndex + maxVisibleIndicators;
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(endIndex - startIndex, (i) {
                    int actualIndex = startIndex + i;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (controller == scrollController1) {
                            currentPage1 = actualIndex;
                          } else {
                            currentPage = actualIndex;
                          }
                        });
                        controller.animateTo(
                          actualIndex * itemsPerPage * itemWidthWithSpacing,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: currentPageLocal == actualIndex ? 10 : 6,
                        height: currentPageLocal == actualIndex ? 10 : 6,
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              currentPageLocal == actualIndex
                                  ? Colors.yellow.shade900
                                  : Colors.grey.shade300,
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
