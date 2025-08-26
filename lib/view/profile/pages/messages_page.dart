import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/view/profile/widgets/chat_screen_profile.dart';
import 'package:simple_nav_bar/view/profile/widgets/favori_product_card.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

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
              'Mes Messages',
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
                      width: MediaQuery.sizeOf(Get.context!).width * 0.93,
                      child: TextField(
                        decoration: InputDecoration(
                          //focusColor: greyColor,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: greyColor, width: 1),
                          ),
                          filled: true,
                          fillColor: whiteColor,
                          hintText: "Rechercher des messages...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 20),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                width: MediaQuery.sizeOf(Get.context!).width,
                color: Colors.transparent,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  itemBuilder: (context, index) {
                    return const ChatScreenProfile();
                  },
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
