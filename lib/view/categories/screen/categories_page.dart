import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/view/categories/pages/cars_drawer.dart';
import 'package:simple_nav_bar/view/categories/widgets/scrolling_vertical_items.dart';

class CategoriesPage extends StatefulWidget {
  final VoidCallback? closeCategories;
  final Animation<Offset> offsetAnimation;

  const CategoriesPage({
    super.key,
    required this.closeCategories,
    required this.offsetAnimation,
  });

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  var isVehiculesOpen = false;

  final categoryController = Get.find<CategoryContorller>();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _closeCarsDrawer() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.offsetAnimation,
      child: Material(
        color: Colors.white,
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: Text(
                      "Categories",
                      style: GoogleFonts.playfairDisplay(
                        //fontWeight: FontWeight.bold,
                        color: greyColor,
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.close, color: blackColor2),
                        onPressed: widget.closeCategories,
                      ),
                    ],
                  ),
                  const SliverToBoxAdapter(child: Divider(height: 1)),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mainMargin,
                      vertical: 8,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final cat = categories1[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: ScrollingVerticalItems(
                            icon: cat['icon'],
                            label: cat['label'],
                            color: cat['color'],
                            onTap: () {
                              categoryController.selectedCategoryIndex.value =
                                  index;
                              if (cat['label'] == "Véhicules") {
                                _controller.forward();
                                setState(() {
                                  isVehiculesOpen = true;
                                });
                              }
                              print(cat['label']);
                              print(categoryController.selectedCategoryIndex.value);
                            },
                          ),
                        );
                      }, childCount: categories1.length),
                    ),
                  ),
                ],
              ),
            ),

            // Conditionally show the drawer
            if (isVehiculesOpen)
              CarsDrawer(
                closeDrawer: () {
                  _controller.reverse();
                  setState(() {
                    isVehiculesOpen = false;
                  });
                },
                offsetAnimation: _offsetAnimation,
              ),
          ],
        ),
      ),
    );
  }

  /* 
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.offsetAnimation,
      child: Material(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: false,
                title: Text(
                  "Categories",
                  style: GoogleFonts.playfairDisplay(
                    fontWeight: FontWeight.bold,
                    color: blackColor2,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.close, color: blackColor2),
                    onPressed: widget.closeCategories,
                  ),
                ],
              ),
              const SliverToBoxAdapter(child: Divider(height: 1)),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: mainMargin,
                  vertical: 8,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final cat = categories1[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: ScrollingVerticalItems(
                        icon: cat['icon'],
                        label: cat['label'],
                        color: cat['color'],
                        onTap: () {
                          // Optional: add logic if needed
                          cat['label'] == "Véhicules"
                              ? CarsDrawer(
                                closeDrawer: _closeCarsDrawer,
                                offsetAnimation: _offsetAnimation,
                              )
                              : null;

                          print(cat['label']);
                        },
                      ),
                    );
                  }, childCount: categories1.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 */
}
