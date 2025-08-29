import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
import 'package:simple_nav_bar/controllers/product_controller/product_controller.dart';
import 'package:simple_nav_bar/view/home/pages/filter_page.dart';
import 'package:simple_nav_bar/view/home/pages/product_details.dart';
import 'package:simple_nav_bar/view/home/widgets/sort_dropdown.dart';
import 'package:simple_nav_bar/view/home/widgets/widget_components.dart';

class CategoryMainContent extends StatefulWidget {
  final ScrollController scrollController, scrollController1, scrollController2;
  final AnimationController controller;
  final Animation<Offset> offsetAnimation;
  final double width, height;
  final double itemWidthWithSpacing;
  final int currentStartIndex;
  final int currentStartIndex1;
  final int currentPage;
  final int currentPage1;
  final int currentPage2;

  const CategoryMainContent({
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
    required this.controller,
    required this.offsetAnimation,
  });

  @override
  State<CategoryMainContent> createState() => _CategoryMainContent();
}

class _CategoryMainContent extends State<CategoryMainContent> {
  final homeController = Get.find<HomeController>();
  final productController = Get.put(ProductController());
  //final filterController = Get.find<FilterController>();
  //var isVehiculesOpen = false;
  late ScrollController scrollController, scrollController1, scrollController2;
  late double width, height;
  late int currentPage;
  late int currentPage1;
  late int currentPage2;
  late double itemWidthWithSpacing;
  late int currentStartIndex;
  late int currentStartIndex1;

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
    final visibleItems =
        productController.products
            .take(productController.visibleCount.value)
            .toList();

    return Positioned.fill(
      child: ListView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 160),
        children: [
          AnimatedContainer(
            duration: Duration(),
            margin: EdgeInsets.symmetric(horizontal: 6),
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
            decoration: BoxDecoration(color: greyColo1.withValues(alpha: 0.1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: whiteColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              //homeController.selectedIndex.value = 4;
                              //widget.controller.forward();
                              //filterController.openFilter();
                              Get.to(
                                () => FilterPage(),
                                transition:
                                    Transition
                                        .leftToRight, // Slide like a drawer
                                duration: const Duration(
                                  milliseconds: 200,
                                ), // Speed up transition
                                curve: Curves.easeInOut,

                                // Optional: smoother animation
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: greyColo1.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              width: 120,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(LucideIcons.listFilter, size: 20),
                                  Text("Filtres"),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    width: 20,
                                    height: 20,
                                    padding: EdgeInsets.only(bottom: 4),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      "8",
                                      style: GoogleFonts.playfairDisplay(
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SortDropdown(),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Telephones - 405.146 annonces trouvees",
                        style: GoogleFonts.playfairDisplay(
                          color: blackColor2,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Obx(() {
                  return Column(
                    children: [
                      GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        itemCount: visibleItems.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (_, index) {
                          return porductCard(
                            visibleItems: visibleItems,
                            index: index,
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      if (!productController.isAllVisible)
                        ElevatedButton(
                          onPressed:
                              productController.isLoadingMore.value
                                  ? null
                                  : productController.showMore,
                          style: ButtonStyle(
                            //maximumSize: WidgetStatePropertyAll(Size.fromWidth(250)),
                            //foregroundColor: WidgetStatePropertyAll(whiteColor),
                            backgroundColor: WidgetStatePropertyAll(
                              primaryColor,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (productController.isLoadingMore.value) ...[
                                SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                              SizedBox(width: 10),
                              Text(
                                "Voir plus",
                                style: GoogleFonts.playfairDisplay(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          footerSections(),

          //const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget porductCard({
    required List<Map<String, dynamic>> visibleItems,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetails(), arguments: [visibleItems, index]);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: blackColor2.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Image.network(
                      visibleItems[index]['image'][0]!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      productController.isFavorite.value =
                          !productController.isFavorite.value;
                    },
                    child: Obx(
                      () => CircleAvatar(
                        backgroundColor:
                            productController.isFavorite.value
                                ? Colors.red
                                : Colors.white,
                        radius: 15,
                        child: Icon(
                          size: 20,
                          productController.isFavorite.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              productController.isFavorite.value
                                  ? Colors.white
                                  : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              child: Text(
                visibleItems[index]['price']!,
                style: GoogleFonts.playfairDisplay(
                  color: blackColor2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              child: Text(
                maxLines: 1,
                visibleItems[index]['description']!,
                style: GoogleFonts.playfairDisplay(
                  color: blackColor2,
                  fontWeight: FontWeight.w500,
                  textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      maxLines: 2,
                      visibleItems[index]['location']!,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.playfairDisplay(
                        color: blackColor2,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        //textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),

                  Text(
                    visibleItems[index]['date']!,
                    style: GoogleFonts.playfairDisplay(
                      color: greyColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
