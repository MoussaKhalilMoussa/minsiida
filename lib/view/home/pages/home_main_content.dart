import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
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

  final homeController = Get.find<HomeController>();

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
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 180),
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: mainMargin),
            height: 170,
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
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(LucideIcons.camera, color: whiteColor),
                  label: Text(
                    'Déposer une annonce',
                    style: GoogleFonts.playfairDisplay(color: whiteColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    shape: StadiumBorder(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          Container(
            margin: EdgeInsets.symmetric(horizontal: mainMargin),
            height: 80, // Optional: define a height for better layout control
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    categories1.map((cat) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: HoverableCategoryItem(
                          icon: cat['icon'],
                          label: cat['label'],
                          color: cat['color'],
                          onTap: () {
                            homeController.homeIndex.value = 1;
                            //print(cat['label']);
                          },
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),

          SizedBox(height: 12),
          sectionHeader(" Meilleures annonces en \n vedette"),
          SizedBox(height: 12),

          Container(
            margin: EdgeInsets.symmetric(horizontal: mainMargin),
            height: height * 0.50,
            child: ListView.builder(
              controller: scrollController2,
              scrollDirection: Axis.horizontal,
              itemCount: featuredAds.length,
              itemBuilder: (context, index) {
                final ad = featuredAds[index];
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
                              child: Image.network(
                                ad['image']!,
                                height: height * 0.25,
                                width: width * 0.32,
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
          const SizedBox(height: 20),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                featuredAds.length - 2,
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
          sectionHeader(" Nos annonces\n recommandées"),
          _horizontalGrid(controller: scrollController1),
          const SizedBox(height: 20),
          sectionHeader(" Annonces tendances\n populaires"),
          _horizontalGrid(controller: scrollController),
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
