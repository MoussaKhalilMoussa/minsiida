import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
import 'package:simple_nav_bar/controllers/location_controller/location_controller.dart';
import 'package:simple_nav_bar/view/home/widgets/filter_elements.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  //final filterController = Get.find<FilterController>();
  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    final locationController = Get.find<LocationController>();
    final cat = categories1[1];
    final subcat = cat['subcategory'];
    return Scaffold(
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

              //leadingWidth: 25,
              title: Text(
                "Filtres",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  color: blackColor2,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Divider(height: 1, thickness: 1),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.back();
                    //widget.controller.reverse();
                    //homeController.resetAllFields();
                    locationController.resetSelection();
                  },
                  icon: Icon(Icons.close, color: blackColor2),
                ),
              ],
            ),

            SliverToBoxAdapter(child: filterElements()),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(style: BorderStyle.none, color: Colors.white),
          ),
        ),
        // for reference, this is the height of the bottom nav bar
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 70,
              margin: EdgeInsets.symmetric(horizontal: mainMargin),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    style: BorderStyle.solid,
                    // this gives us the effect of shadow on top of navbars box under FAB
                    color: Colors.grey.withValues(alpha: 0.3),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      homeController.resetAllFields();
                      locationController.resetSelection();
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size.fromWidth(150)),
                      backgroundColor: WidgetStatePropertyAll(whiteColor),
                    ),
                    child: Text(
                      "Effacer",
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size.fromWidth(150)),
                      backgroundColor: WidgetStatePropertyAll(primaryColor),
                    ),
                    child: Text(
                      "Appliquer",
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
