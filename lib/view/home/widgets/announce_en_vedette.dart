import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_nav_bar/common_widgets/price_widget.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';
import 'package:simple_nav_bar/controllers/product_controller/post_details_controller.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/home/pages/post_details.dart';

class AnnounceEnVedette extends StatefulWidget {
  const AnnounceEnVedette({
    super.key,
    required this.scrollController2,
    required this.homeController,
    required this.postController,
    required this.postDetailsController,
    required this.width,
    required this.height,
    required this.isLoading,
  });

  final ScrollController scrollController2;
  final HomeController homeController;
  final PostController postController;
  final PosttDetailsController postDetailsController;
  final double width, height;
  final bool isLoading;

  @override
  State<AnnounceEnVedette> createState() => _AnnounceEnVedetteState();
}

class _AnnounceEnVedetteState extends State<AnnounceEnVedette> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mainMargin),
      height: widget.height * 0.50,
      child:
          widget.isLoading
              ? ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: widget.width * 0.32,
                    height: widget.height * 0.25,
                    //margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Shimmer.fromColors(
                            baseColor: shimmmerBaseColor!,
                            highlightColor: shimmerhighlightColor!,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: shimmmerBaseColor,
                              ),
                              height: widget.height * 0.25,
                              width: widget.width * 0.32,
                            ),
                          ),
                        ),

                        SizedBox(height: 8.h),
                        Row(
                          spacing: 5,
                          children: [
                            Shimmer.fromColors(
                              baseColor: shimmmerBaseColor!,
                              highlightColor: shimmerhighlightColor!,
                              child: CircleAvatar(
                                backgroundColor: shimmmerBaseColor,
                                radius: 12,
                              ),
                            ),
                            Shimmer.fromColors(
                              baseColor: shimmmerBaseColor!,
                              highlightColor: shimmerhighlightColor!,
                              child: Container(
                                width: widget.width / 5,
                                height: 15,
                                color: shimmmerBaseColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Shimmer.fromColors(
                          baseColor: shimmmerBaseColor!,
                          highlightColor: shimmerhighlightColor!,
                          child: Container(
                            width: widget.width * 0.32,
                            height: 15,
                            color: shimmmerBaseColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Shimmer.fromColors(
                          baseColor: shimmmerBaseColor!,
                          highlightColor: shimmerhighlightColor!,
                          child: Container(
                            width: widget.width * 0.32,
                            height: 15,
                            color: shimmmerBaseColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Shimmer.fromColors(
                          baseColor: shimmmerBaseColor!,
                          highlightColor: shimmerhighlightColor!,
                          child: Container(
                            width: widget.width * 0.32,
                            height: 15,
                            color: shimmmerBaseColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Shimmer.fromColors(
                          baseColor: shimmmerBaseColor!,
                          highlightColor: shimmerhighlightColor!,
                          child: Container(
                            width: widget.width * 0.32,
                            height: 15,
                            color: shimmmerBaseColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  );
                },
              )
              : ListView.builder(
                controller: widget.scrollController2,
                scrollDirection: Axis.horizontal,
                itemCount: widget.homeController.featuredPosts.length,
                itemBuilder: (context, index) {
                  //final ad = featuredAds[index];
                  final post = widget.homeController.featuredPosts[index];
                  final user =
                      widget.homeController.usersForfeaturedPosts[post.userId];

                  final isLiked = widget.postController.isPostLiked(post.id!);

                  if (user == null) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: greyColo1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: widget.width * 0.32,
                      height: widget.height * 0.25,
                      child: Center(
                        child: CircularProgressIndicator(
                          constraints: BoxConstraints.tight(
                            Size.fromRadius(12.r),
                          ),
                          valueColor: AlwaysStoppedAnimation(primaryColor),
                        ),
                      ),
                    );
                  }
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: widget.width * 0.32,
                    height: widget.height * 0.25,
                    //margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[200],
                                ),
                                height: widget.height * 0.25,
                                width: widget.width * 0.32,
                                child: InkWell(
                                  onTap: () {
                                    widget.postDetailsController.getUser(
                                      userId: post.userId!,
                                    );

                                    Get.to(
                                      () => PostDetails(),
                                      arguments: post,
                                    );
                                    widget.postController.viewPost(
                                      postId: post.id!,
                                    );
                                  },
                                  child: Image.network(
                                    post.mediaUrls!.first.content == null
                                        ? 'https://cdn.pixabay.com/photo/2016/11/20/09/06/laptop-1842297_1280.jpg'
                                        : "${post.mediaUrls!.first.content}",
                                    height: widget.height * 0.25,
                                    width: widget.width * 0.32,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 8,
                              right: 8,
                              child: InkWell(
                                onTap: () {
                                  widget.postController.toggleLike(post);
                                  setState(() {});
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      isLiked ? Colors.red : Colors.white,
                                  radius: 12,
                                  child: Icon(
                                    size: 18,
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isLiked ? Colors.white : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          spacing: 5,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.yellow.shade900,
                              radius: 12,
                              child: Text(
                                (user.name?.isNotEmpty ?? false)
                                    ? user.name![0].toUpperCase()
                                    : "U", // fallback initial
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                            Text(
                              tooShortTruncateWithEllipsis(
                                user.name ?? "No name",
                              ),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: blackColor2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          post.description!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: blackColor2,
                            textStyle: TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        PriceWidget(
                          price: post.price!.toString(),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: blackColor2,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          maxLines: 2,
                          post.location == null
                              ? "N'Djamena /\nN'Djamena-Centre"
                              : "",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: greyColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          formatShortDateNumber(post.date!.toIso8601String()),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: greyColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        /* Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100.withValues(alpha: .5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Livraison possible',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ), */
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
