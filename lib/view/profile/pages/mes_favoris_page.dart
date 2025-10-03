import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/favori_product_card.dart';

class MesFavoris extends StatelessWidget {
  MesFavoris({super.key});
  final postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Obx(() {
        return CustomScrollView(
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
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                ),
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
                        child: TextFormField(
                          style: GoogleFonts.poppins(color: blackColor),
                          onChanged:
                              (value) =>
                                  postController.searchMyFavorites(value),
                          decoration: InputDecoration(
                            //focusColor: greyColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: greyColor,
                                width: 1,
                              ),
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
                          shape:
                              WidgetStateProperty.resolveWith<OutlinedBorder>((
                                Set<WidgetState> states,
                              ) {
                                final isPressed = states.contains(
                                  WidgetState.pressed,
                                );
                                return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color:
                                        isPressed
                                            ? Colors.grey
                                            : Colors.transparent,
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
                  child:
                      postController.filteredFavoris.isEmpty
                          ? Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.sizeOf(context).height / 3,
                            ),
                            child: Center(
                              child: Text(
                                "Aucun favoris",
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                            ),
                          )
                          : GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: postController.filteredFavoris.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.60,
                                ),
                            itemBuilder: (context, index) {
                              final post =
                                  postController.filteredFavoris[index];
                              final user =
                                  postController.usersOfLikedPosts[post
                                      .userId] ??
                                  UserProfile(
                                    id: post.userId!,
                                    name: "Loading...",
                                  );

                              return FavoriProductCard(
                                post: post,
                                user: user,
                                controller: postController,
                              );
                            },
                          ),
                ),
              ]),
            ),
          ],
        );
      }),
    );
  }
}
