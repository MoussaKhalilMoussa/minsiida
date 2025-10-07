import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/common_widgets/price_widget.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';
import 'package:simple_nav_bar/models/post.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';

class FavoriProductCard extends StatefulWidget {
  final Post post;
  final UserProfile user;
  final PostController controller;
  //final bool isLiked;

  const FavoriProductCard({
    super.key,
    required this.post,
    required this.user,
    required this.controller,
    //required this.isLiked,
  });

  @override
  State<FavoriProductCard> createState() => _FavoriProductCardState();
}

class _FavoriProductCardState extends State<FavoriProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: greyColor.withValues(alpha: 0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Image.network(
                    widget.post.mediaUrls?.isNotEmpty == true
                        ? widget.post.mediaUrls!.first.content ?? ""
                        : "https://via.placeholder.com/150", // fallback
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Obx(() {
                  final isLiked = widget.controller.isPostLiked(
                    widget.post.id!,
                  );
                  return InkWell(
                    onTap: () => widget.controller.toggleLike(widget.post),
                    child: CircleAvatar(
                      backgroundColor: isLiked ? Colors.red : Colors.white,
                      radius: 15,
                      child: Icon(
                        size: 20,
                        isLiked ? Ionicons.trash : Ionicons.trash_outline,
                        color: isLiked ? Colors.white : Colors.red,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.description ?? "No title",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),

                PriceWidget(
                  price: widget.post.price.toString(),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: blueColor,
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Ionicons.person_outline, size: 12, color: greyColor),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.user.name == null
                            ? " "
                            : widget.user.name!,
                        style: GoogleFonts.poppins(
                          color: greyColor,
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Ionicons.location_outline, size: 12, color: greyColor),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.post.location ?? "Unknown location",
                        style: GoogleFonts.poppins(
                          color: greyColor,
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Saved ${formatShortDateNumber(widget.post.date!.toIso8601String())}",
                  style: GoogleFonts.poppins(color: greyColor, fontSize: 10),
                ),
                const SizedBox(height: 2),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to details page with this post
                    // Example: Get.to(() => PostDetailsPage(post: post));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    foregroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 30),
                  ),
                  child: Text(
                    "Voir les détails",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
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
