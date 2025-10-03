import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/favori_product_card.dart';

class Favorites extends StatefulWidget {
  final VoidCallback? closeFavorites;
  final Animation<Offset> offsetAnimation;

  const Favorites({
    super.key,
    required this.closeFavorites,
    required this.offsetAnimation,
  });

  @override
  State<Favorites> createState() => _Favorites();
}

class _Favorites extends State<Favorites> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  var isVehiculesOpen = false;

  //final categoryController = Get.find<CategoryContorller>();
  final postController = Get.find<PostController>();

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
                      "Favorites",
                      style: GoogleFonts.playfairDisplay(
                        //fontWeight: FontWeight.bold,
                        color: greyColor,
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.close, color: blackColor2),
                        onPressed: widget.closeFavorites,
                      ),
                    ],
                  ),

                  const SliverToBoxAdapter(child: Divider(height: 1)),
                  Obx(() {
                    return SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          width: MediaQuery.sizeOf(Get.context!).width,
                          margin: EdgeInsets.only(right: 12, left: 12, top: 20),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width:
                                    MediaQuery.sizeOf(Get.context!).width *
                                    0.79,
                                child: TextFormField(
                                  style: GoogleFonts.poppins(color: blackColor),
                                  onChanged:
                                      (value) => postController
                                          .searchMyFavorites(value),
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
                                      borderSide: BorderSide(color: greyColor),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              IconButton.filled(
                                iconSize: 33,
                                style: ButtonStyle(
                                  iconColor: WidgetStateProperty.all(greyColor),
                                  backgroundColor: WidgetStateProperty.all(
                                    whiteColor,
                                  ),
                                  shape: WidgetStateProperty.resolveWith<
                                    OutlinedBorder
                                  >((Set<WidgetState> states) {
                                    final isPressed = states.contains(
                                      WidgetState.pressed,
                                    );
                                    return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                        color: greyColor.withValues(alpha: 0.7),
                                        width: 2,
                                      ),
                                    );
                                  }),
                                ),
                                onPressed: () {
                                  // Implement filter functionality here
                                  print("Filter button pressed");
                                },
                                icon: Icon(
                                  Ionicons.filter_outline,
                                  color: greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 14),
                        Container(
                          margin: EdgeInsets.only(left: 12, right: 12),
                          width: MediaQuery.sizeOf(Get.context!).width,
                          child:
                              postController.filteredFavoris.isEmpty
                                  ? Padding(
                                    padding: EdgeInsets.only(
                                      top:
                                          MediaQuery.sizeOf(context).height / 3,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Aucun favoris",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                  : GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        postController.filteredFavoris.length,
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
                                              .userId];

                                      return FavoriProductCard(
                                        post: post,
                                        user: user!,
                                        controller: postController,
                                      );
                                    },
                                  ),
                        ),
                      ]),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
