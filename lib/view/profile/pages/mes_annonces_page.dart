import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/product_card.dart';

class MesAnnoncesPage extends StatelessWidget {
  const MesAnnoncesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        //physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            backgroundColor: whiteColor,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Ionicons.chevron_back_outline),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Text(
              'My Ads',
              style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
            ),
            floating: true,
            snap: true,
          ),
          const SliverToBoxAdapter(child: Divider(height: 1)),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                width: MediaQuery.sizeOf(Get.context!).width,
                margin: EdgeInsets.only(right: 12, left: 12, top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.sizeOf(Get.context!).width * 0.79,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Recherche...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton.filled(
                      iconSize: 33,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(primaryColor),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            side: BorderSide(),
                          ),
                        ),
                      ),
                      //color: primaryColor,
                      onPressed: () {},
                      icon: Icon(Ionicons.add_outline, color: whiteColor),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                width: MediaQuery.sizeOf(Get.context!).width,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ProductCard();
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
