import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/view/home/widgets/widget_components.dart';
import 'package:simple_nav_bar/view/menu/widgets/sub_title.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  },
                  icon: Icon(Icons.close, color: blackColor2),
                ),
              ],
            ),

            SliverToBoxAdapter(child: footerSections()),
          ],
        ),
      ),
    );
  }
}
