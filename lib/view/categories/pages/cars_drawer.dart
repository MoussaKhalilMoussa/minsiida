import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';

Widget CarsDrawer({
  required VoidCallback? closeDrawer,
  required Animation<Offset> offsetAnimation,
}) {
  final categoryController = Get.find<CategoryContorller>();

  return SlideTransition(
    position: offsetAnimation,
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              snap: false,
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: closeDrawer,
                icon: Icon(Icons.close, color: greyColor),
              ),
              leadingWidth: 25,
              title: Text(
                "Véhicules",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: greyColor,
                  fontWeight: FontWeight.w500
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Divider(height: 1, thickness: 1),
              ),
            ),

            // List of subcategories
            Obx(() {
              final cat =
                  categoryController.categories1[categoryController.selectedCategoryIndex.value];
              final subcat = cat.subcategories!;
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final sub = subcat[index];
                  return InkWell(
                    onTap: () {
                      print(sub);
                    },
                    child: Container(
                      height: 36,
                      width: double.infinity,
                      // or only on selection
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        sub.name!,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }, childCount: subcat.length),
              );
            }),
          ],
        ),
      ),
    ),
  );
}
