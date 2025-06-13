import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/view/menu/widgets/sub_title.dart';

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
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  color: greyColor,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Divider(height: 1, thickness: 1),
              ),
            ),

            // List of subcategories
            Obx(() {
              final cat = categories1[categoryController.selectedCategoryIndex.value];
              final subcat = cat['subcategory'];

              return SliverFixedExtentList(
                itemExtent: 36,
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final sub = subcat[index];
                    return InkWell(
                      onTap: () {
                        print(sub);
                      },
                      child: subTitle(title: sub),
                    );
                  },
                  childCount: subcat.length,
                ),
              );
            }),
          ],
        ),
      ),
    ),
  );
}
