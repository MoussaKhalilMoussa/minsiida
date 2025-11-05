import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/common_widgets/price_widget.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';
import 'package:simple_nav_bar/controllers/product_controller/post_details_controller.dart';
import 'package:simple_nav_bar/models/post.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/home/widgets/feature_ads.dart';
import 'package:simple_nav_bar/view/home/widgets/profile_summary.dart';
import 'package:simple_nav_bar/view/home/widgets/shipping_method.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/message_component/message_chat_room.dart';
import 'package:simple_nav_bar/view/profile/pages/messages_page.dart';

class PostDetails extends StatelessWidget {
  PostDetails({super.key});

  final PageController _pageController = PageController();
  final scrollController = ScrollController(initialScrollOffset: 0);
  final postDetailsController = Get.find<PosttDetailsController>();
  final postController = Get.find<PostController>();

  var buttonSize = Size(MediaQuery.sizeOf(Get.context!).width / 2.2, 50);

  @override
  Widget build(BuildContext context) {
    final bottomPadding = Platform.isIOS ? 30.0 : 8.0;
    //final bottomPadding = Platform.isIOS ? 24.0 : 12.0;
    final leftPadding = Platform.isIOS ? 14.0 : 8.0;
    final rightPadding = Platform.isIOS ? 14.0 : 8.0;

    final Post post = Get.arguments;

    final List<String> imageUrls =
        post.mediaUrls?.map((m) => m.content ?? '').toList() ?? [];

    final Map<String, String> characteristics = {
      for (var c in post.characteristics ?? [])
        if (c.key != null && c.value != null) c.key!: c.value!,
    };
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        final currentIndex = postDetailsController.selectedImageIndex.value + 1;
        final isLiked = postController.isPostLiked(post.id!);

        final total = post.mediaUrls?.length;

        return SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(LucideIcons.chevronLeft, color: blackColor2),
                ),
                //title: Text("Product Details"),
                pinned: true,
                elevation: 0,
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(LucideIcons.share2)),
                  IconButton(
                    onPressed: () {
                      postController.toggleLike(post);
                    },
                    icon: Icon(
                      size: 28,
                      isLiked ? Icons.favorite : LucideIcons.heart,
                      color: isLiked ? Colors.red : null,
                    ),
                  ),

                  PopupMenuButton(
                    menuPadding: EdgeInsets.only(left: 0, right: 0),
                    color: whiteColor,
                    icon: const Icon(LucideIcons.moreVertical),
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(
                            //padding: EdgeInsets.only(right: 4),
                            child: const Text("Signaler l'annonce"),
                            onTap:
                                () => Future.delayed(
                                  Duration.zero,
                                  () => postController.openReportDialog(
                                    postId: post.id!,
                                  ),
                                ),
                          ),
                        ],
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: Divider(height: 1, thickness: 1),
                ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: 400,
                          child: PageView.builder(
                            controller: _pageController,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: imageUrls.length,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(8),
                                ),
                                child: Image.network(
                                  imageUrls[index],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "$currentIndex / $total",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 90,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            final isSelected =
                                postDetailsController
                                    .selectedImageIndex
                                    .value ==
                                index;
                            return GestureDetector(
                              onTap: () {
                                postDetailsController.selectedImageIndex.value =
                                    index;
                                _pageController.jumpToPage(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? Colors.blue
                                            : Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrls[index],
                                    width: MediaQuery.sizeOf(context).width / 6,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: PriceWidget(
                        price: post.price!.toString(),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: blackColor2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${post.title}",
                        style: GoogleFonts.poppins(
                          color: blackColor2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 24.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Text(
                              "Accueil > Téléphones & Objets connectés > Champagne-Ardenne > Marne > Châlons-en-Champagne 51000 > iPhone 12 Pro",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: greyColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 25,
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  LucideIcons.mapPin,
                                  size: 18,
                                  color: greyColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "Goudji,N'djamena",
                                  style: GoogleFonts.playfairDisplay(
                                    fontWeight: FontWeight.w400,
                                    color: greyColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              formatShortDateNumber(
                                post.date!.toIso8601String(),
                              ),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: greyColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 0,
                        bottom: 8,
                      ),
                      child: Divider(
                        height: 4,
                        thickness: 8,
                        color: greyColo1.withValues(alpha: 0.5),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Caractéristiques de l'annonce",
                            style: GoogleFonts.poppins(
                              color: blackColor2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          ...characteristics.entries.map(
                            (entry) => Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      entry.key,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        color: greyColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      entry.value,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: blackColor2,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Description",
                        style: GoogleFonts.poppins(
                          color: blackColor2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        post.description!,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                          color: greyColor,
                          //fontSize: 30,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Choisir un courier",
                        style: GoogleFonts.poppins(
                          color: blackColor2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /*    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: shippingMethod(
                        icon: "📦",
                        title: "Mondial Relay",
                        subTitle: "En point de retrait sous 3-5 jours",
                        price: "1500 XAF",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: shippingMethod(
                        icon: "🚚",
                        title: "Shop2Shop by Chronopost",
                        subTitle: "En point de retrait sous 3-5 jours",
                        price: "1000 XAF",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: shippingMethod(
                        icon: "🏠",
                        title: "Colissimo",
                        subTitle: "À votre domicile sous 2-3 jours",
                        price: "2500 XAF",
                      ),
                    ), */
                    SizedBox(height: 4),
                    Padding(padding: EdgeInsets.all(8), child: ProfleSummary()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _sectionHeader(
                        "Autres annonces interessantes",
                        "Voir plus d'annonces",
                      ),
                    ),
                    FeaturedAdsListView(
                      ads: featuredAds,
                      //controller: scrollController,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      }),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          leftPadding,
          8,
          rightPadding,
          bottomPadding,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},

              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(whiteColor),
                backgroundColor: WidgetStatePropertyAll(Colors.orange.shade700),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                fixedSize: WidgetStatePropertyAll(buttonSize),
              ),

              child: Text(
                "Profile",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (postController.currentUserId == post.userId) {
                  Get.to(() => MessagesPage());
                } else {
                  //Get.to(() => MessageChatRoom());
                }
              },
              style: ButtonStyle(
                //elevation: WidgetStatePropertyAll(0),
                foregroundColor: WidgetStatePropertyAll(whiteColor),
                backgroundColor: WidgetStatePropertyAll(primaryColor),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                fixedSize: WidgetStatePropertyAll(buttonSize),
              ),
              child: Text(
                "Message",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mainMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: blackColor2,
              fontSize: 12.sp,
            ),
          ),
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: greyColor,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 3),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 10.sp,
                    color: greyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
