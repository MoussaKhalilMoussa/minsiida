import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/view/categories/models/category.dart';
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
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 20 ,
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
                        //final cat = categories1[index];
                        final cat = categoryController.categories1[index];
                        final categoryIcon =
                            iconsMap[cat.name] ??
                            CategoryIcon(LucideIcons.helpCircle, Colors.black);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: ScrollingVerticalItems(
                            icon: categoryIcon.icon,
                            label: cat.name!,
                            color: categoryIcon.color,
                            onTap: () {
                              categoryController.selectedCategoryIndex.value =
                                  index;
                              if (cat.name! == "Véhicules") {
                                _controller.forward();
                                setState(() {
                                  isVehiculesOpen = true;
                                });
                              }
                              print(cat.name!);
                              print(
                                categoryController.selectedCategoryIndex.value,
                              );
                            },
                          ),
                        );
                      }, childCount: categoryController.categories1.length),
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
}
