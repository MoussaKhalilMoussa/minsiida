import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
import 'package:simple_nav_bar/view/home/screen/filter_page.dart';
import 'package:simple_nav_bar/view/home/widgets/sort_dropdown.dart';
import 'package:simple_nav_bar/view/home/widgets/widget_components.dart';

class CategoryMainContent extends StatefulWidget {
  final ScrollController scrollController, scrollController1, scrollController2;
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
  });

  @override
  State<CategoryMainContent> createState() => _CategoryMainContent();
}

class _CategoryMainContent extends State<CategoryMainContent> {
  //bool _isFilterDrawerOpen = false;
  final homeController = Get.find<HomeController>();

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
    return Positioned.fill(
      child: ListView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 160),
        children: [
          AnimatedContainer(
            duration: Duration(),
            margin: EdgeInsets.symmetric(horizontal: 6),
            //height: MediaQuery.sizeOf(context).height *2.2,
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
            decoration: BoxDecoration(
              color: Color(0xFFF4EDF8),
              //borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  //margin: EdgeInsets.all(0),
                  //width: MediaQuery.sizeOf(Get.context!).width * 1.1,
                  decoration: BoxDecoration(color: whiteColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => FilterPage(),
                            transition:
                                Transition
                                    .leftToRight, // Slide like a drawer
                            duration: const Duration(
                              milliseconds: 200,
                            ), // Speed up transition
                            curve:
                                Curves
                                    .easeInOut, // Optional: smoother animation
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: greyColo1.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                          ),
                          width: 120,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                ),
                Text(
                  'Categori Main content!',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
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

  Widget _horizontalGrid({required controller}) {
    // Width of one item + horizontal margin
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    final double itemWidth = width * 0.45;
    final double spacing = 14.0;
    final double itemWidthWithSpacing = itemWidth + spacing;
    final isFirstItem =
        controller == scrollController1
            ? currentStartIndex1 == 0
            : currentStartIndex == 0;

    final isLastItem =
        controller == scrollController1
            ? currentStartIndex1 >= featuredAds.length - 2
            : currentStartIndex >= featuredAds.length - 2;

    return SizedBox(
      height: height * 0.52,
      child: Stack(
        children: [
          SizedBox(
            height: height * 0.5,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 14),
              shrinkWrap: false,
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: featuredAds.length,
              itemBuilder: (context, index) {
                final ad = featuredAds[index];

                return Container(
                  padding: EdgeInsets.all(8),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: width * 0.45,
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
                              width: width * 0.45,
                              child: Image.network(
                                ad['image']!,
                                height: height * 0.25,
                                width: width * 0.45,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 14,
                              child: Icon(Icons.favorite_border),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        spacing: 5,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.yellow.shade900,
                            radius: 12,
                            child: Text(
                              ad['name']![0].toUpperCase(),
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 12,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          Text(
                            ad['name']!,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 12,
                              color: blackColor2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        ad['description']!,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          color: blackColor2,
                          textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        ad['price']!,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          color: blackColor2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        ad['location']!,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          color: greyColor,
                        ),
                      ),
                      Text(
                        ad['date']!,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          color: greyColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100.withValues(alpha: .5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Livraison possible',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 11,
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Forward and Backward buttons
          Positioned(
            top: 145,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: mainMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: MediaQuery.sizeOf(context).width / 1.9,
                children: [
                  //backword button
                  InkWell(
                    onTap:
                        isFirstItem
                            ? null // disables interaction
                            : () {
                              final itemsPerPage =
                                  (width / itemWidthWithSpacing).floor();
                              if (controller == scrollController1) {
                                if (currentStartIndex1 > 0) {
                                  setState(() {
                                    currentStartIndex1--;

                                    if (currentStartIndex1 < 0) {
                                      currentStartIndex1 = 0;
                                    }
                                    currentPage1 = currentStartIndex1;
                                  });
                                  controller.animateTo(
                                    (currentStartIndex1 * itemWidthWithSpacing),
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.linear,
                                  );
                                }
                              } else {
                                if (currentStartIndex > 0) {
                                  setState(() {
                                    currentStartIndex--;
                                    if (currentStartIndex < 0) {
                                      currentStartIndex = 0;
                                    }
                                    currentPage = currentStartIndex;
                                  });
                                  controller.animateTo(
                                    (currentStartIndex * itemWidthWithSpacing),
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.linear,
                                  );
                                }
                              }
                            },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            isFirstItem
                                ? greyColo1.withValues(alpha: 0.8)
                                : whiteColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 12,
                        color: greyColor,
                      ),
                    ),
                  ),
                  // forword button
                  InkWell(
                    onTap:
                        isLastItem
                            ? null
                            : () {
                              if (controller == scrollController1) {
                                if (currentStartIndex1 <
                                    featuredAds.length - 1) {
                                  // Ensure 2 visible
                                  setState(() {
                                    currentStartIndex1++;
                                    currentPage1 = currentStartIndex1;
                                  });
                                  controller.animateTo(
                                    currentStartIndex1 * itemWidthWithSpacing,
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.linear,
                                  );
                                }
                              } else {
                                if (currentStartIndex <
                                    featuredAds.length - 1) {
                                  // Ensure 2 visible
                                  setState(() {
                                    currentStartIndex++;
                                    currentPage = currentStartIndex;
                                  });
                                  controller.animateTo(
                                    currentStartIndex * itemWidthWithSpacing,
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.linear,
                                  );
                                }
                              }
                            },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isLastItem ? greyColo1 : whiteColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
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

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                featuredAds.length - 1,
                (i) => InkWell(
                  onTap: () {
                    if (controller == scrollController1) {
                      setState(() {
                        currentStartIndex1 = i;
                        currentPage1 = i;
                      });
                      controller.animateTo(
                        (currentStartIndex1 * itemWidthWithSpacing),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      setState(() {
                        currentStartIndex = i;
                        currentPage = i;
                      });
                      controller.animateTo(
                        (currentStartIndex * itemWidthWithSpacing),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child:
                      controller == scrollController1
                          ? Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  currentPage1 == i
                                      ? Colors.yellow.shade900
                                      : Colors.grey.shade300,
                            ),
                          )
                          : Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  currentPage == i
                                      ? Colors.yellow.shade900
                                      : Colors.grey.shade300,
                            ),
                          ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
