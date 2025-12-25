import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/common_widgets/price_widget.dart';
import 'package:simple_nav_bar/common_widgets/shimmer_container.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';
import 'package:simple_nav_bar/controllers/product_controller/post_details_controller.dart';
import 'package:simple_nav_bar/models/post.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/home/pages/post_details.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.posts,
    required this.postController,
    required this.postDetailsController,
    required this.isLoading,
  });
  final RxList<dynamic> posts;
  final PostController postController;
  final PosttDetailsController postDetailsController;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12),
          itemCount: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (_, index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: blackColor2.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                    child: ShimmerContainer(
                      height: 150.h,
                      width: double.infinity,
                      borderRadius: 8,
                    ),
                  ),
                  //SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2,
                    ),
                    child: ShimmerContainer(
                      height: 20,
                      width: 90,
                      margin: EdgeInsets.all(0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2,
                    ),
                    child: ShimmerContainer(
                      height: 20.0,
                      width: 170.0,
                      margin: EdgeInsets.all(0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ShimmerContainer(
                            height: 20.0,
                            width: 100.0,
                            margin: EdgeInsets.all(0),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: ShimmerContainer(
                            height: 20.0,
                            width: 80.0,
                            margin: EdgeInsets.all(0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        )
        : GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12),
          itemCount: posts.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (_, index) {
            Post post = posts[index];
            return GestureDetector(
              onTap: () {
                postDetailsController.getUser(userId: post.userId!);
                Get.to(() => PostDetails(), arguments: post);
                postController.viewPost(postId: post.id!);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: blackColor2.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 150.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: Image.network(
                              post.mediaUrls![0].content!,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Obx(() {
                          final RxBool isLiked = false.obs;
                          isLiked.value = postController.isPostLiked(post.id!);
                          return Positioned(
                            top: 8,
                            right: 8,
                            child: InkWell(
                              onTap: () {
                                postController.toggleLike(post);
                                // setState(() {});
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    isLiked.value ? Colors.red : Colors.white,
                                radius: 12,
                                child: Icon(
                                  size: 18,
                                  isLiked.value
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      isLiked.value ? Colors.white : Colors.red,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    //SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2,
                      ),
                      child: PriceWidget(
                        price: post.price!.toString(),
                        color: blackColor2,
                        fontWeight: FontWeight.w600,
                        fontSize: null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2,
                      ),
                      child: Text(
                        maxLines: 1,
                        post.description!,
                        style: GoogleFonts.poppins(
                          color: greyColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 2,
                              post.location ?? "no location",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: blackColor2,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                //textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ),

                          Text(
                            formatShortDateNumber(post.date!.toIso8601String()),
                            style: GoogleFonts.poppins(
                              color: greyColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                overflow: TextOverflow.ellipsis,
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
          },
        );
  }
}
