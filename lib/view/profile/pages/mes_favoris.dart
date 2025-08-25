import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/view/profile/widgets/favori_product_card.dart';

class MesFavoris extends StatelessWidget {
  const MesFavoris({super.key});

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
              'Mes Favoris',
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
                          //focusColor: greyColor,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: greyColor, width: 1),
                          ),
                          filled: true,
                          fillColor: whiteColor,
                          hintText: "Rechercher des favoris...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton.filled(
                      iconSize: 33,
                      style: ButtonStyle(
                        iconColor: WidgetStateProperty.all(greyColor),
                        backgroundColor: WidgetStateProperty.all(whiteColor),
                        shape: WidgetStateProperty.resolveWith<OutlinedBorder>((
                          Set<WidgetState> states,
                        ) {
                          final isPressed = states.contains(
                            WidgetState.pressed,
                          );
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color:
                                  isPressed ? Colors.grey : Colors.transparent,
                              width: 2,
                            ),
                          );
                        }),
                      ),
                      onPressed: () {
                        // Implement filter functionality here
                        print("Filter button pressed");
                      },
                      icon: Icon(Ionicons.filter_outline, color: greyColor),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                width: MediaQuery.sizeOf(Get.context!).width,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.60,
                  ),
                  itemBuilder: (context, index) {
                    return const FavoriProductCard();
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
