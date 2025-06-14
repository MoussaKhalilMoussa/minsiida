import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
import 'package:simple_nav_bar/view/home/pages/filter_page.dart';
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
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
            decoration: BoxDecoration(color: Color(0xFFF4EDF8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: whiteColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => FilterPage(),
                            transition:
                                Transition.leftToRight, // Slide like a drawer
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
}
