import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/common_widgets/price_widget.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';
import 'package:simple_nav_bar/controllers/product_controller/post_details_controller.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/home/pages/post_details.dart';

// ignore: must_be_immutable
class AnnounceRecommande extends StatefulWidget {
  AnnounceRecommande({
    super.key,
    required this.scrollController1,
    required this.homeController,
    required this.postController,
    required this.postDetailsController,
    required this.controller,
    required this.width,
    required this.height,
    required this.currentPage,
    required this.currentPage1,
  });

  final ScrollController scrollController1;
  final HomeController homeController;
  final PostController postController;
  final PosttDetailsController postDetailsController;
  final ScrollController controller;
  final double width, height;
  int currentPage;
  int currentPage1;

  @override
  State<AnnounceRecommande> createState() => _AnnounceRecommandeState();
}

class _AnnounceRecommandeState extends State<AnnounceRecommande> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    final double itemWidth = width * 0.45;
    final double spacing = 14.0;
    final double itemWidthWithSpacing = itemWidth + spacing;

    // Each page shows 2 items
    const int itemsPerPage = 2;

    int totalPages =
        (widget.homeController.suggestedPosts.length / itemsPerPage).ceil();

    int currentPageLocal =
        widget.controller == widget.scrollController1
            ? widget.currentPage1
            : widget.currentPage;

    final bool isFirstPage = currentPageLocal == 0;
    final bool isLastPage = currentPageLocal >= totalPages - 1;

    return SizedBox(
      height: height * 0.52,
      child: Stack(
        children: [
          SizedBox(
            height: height * 0.5,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: spacing),
              shrinkWrap: false,
              physics: NeverScrollableScrollPhysics(),
              controller: widget.controller,
              scrollDirection: Axis.horizontal,
              itemCount: widget.homeController.suggestedPosts.length,
              itemBuilder: (context, index) {
                final post = widget.homeController.suggestedPosts[index];
                final user =
                    widget.homeController.usersForSuggestedPosts[post.userId];
                final isLiked = widget.postController.isPostLiked(post.id!);

                if (user == null) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: greyColo1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: itemWidth,
                    height: height * 0.25,
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
                  width: itemWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: height * 0.25,
                              width: itemWidth,
                              color: Colors.grey[200],
                              child: InkWell(
                                onTap: () {
                                  widget.postDetailsController.getUser(
                                    userId: post.userId!,
                                  );
                                  Get.to(() => PostDetails(), arguments: post);

                                  widget.postController.viewPost(
                                    postId: post.id!,
                                  );
                                },
                                child: Image.network(
                                  post.mediaUrls!.first.content ??
                                      'https://cdn.pixabay.com/photo/2016/11/20/09/06/laptop-1842297_1280.jpg',
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
                      SizedBox(height: 8),
                      Row(
                        //spacing: 5,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.yellow.shade900,
                            radius: 12,
                            child: Text(
                              (user.name?.isNotEmpty ?? false)
                                  ? user.name![0].toUpperCase()
                                  : "U",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            user.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: blackColor2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        post.description!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: blackColor2,
                          textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      SizedBox(height: 8),
                      PriceWidget(
                        price: post.price!.toString(),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: blackColor2,
                      ),
                      SizedBox(height: 8),
                      Text(
                        post.location ?? "N'Djamena /\nN'Djamena-Centre",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: greyColor,
                        ),
                      ),
                      Text(
                        formatShortDateNumber(post.date!.toIso8601String()),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          /// 🔹 Forward & Backward buttons (page-based now)
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: mainMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: MediaQuery.sizeOf(context).width / 1.9,
                children: [
                  InkWell(
                    onTap:
                        isFirstPage
                            ? null
                            : () {
                              setState(() {
                                if (widget.controller ==
                                    widget.scrollController1) {
                                  widget.currentPage1--;
                                } else {
                                  widget.currentPage--;
                                }
                              });
                              widget.controller.animateTo(
                                (currentPageLocal - 1) *
                                    itemsPerPage *
                                    itemWidthWithSpacing,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                    child: CircleAvatar(
                      backgroundColor:
                          isFirstPage
                              ? greyColo1.withValues(alpha: 0.5)
                              : whiteColor,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 12,
                        color: greyColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap:
                        isLastPage
                            ? null
                            : () {
                              setState(() {
                                if (widget.controller ==
                                    widget.scrollController1) {
                                  widget.currentPage1++;
                                } else {
                                  widget.currentPage++;
                                }
                              });
                              widget.controller.animateTo(
                                (currentPageLocal + 1) *
                                    itemsPerPage *
                                    itemWidthWithSpacing,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                    child: CircleAvatar(
                      backgroundColor:
                          isLastPage
                              ? greyColo1.withValues(alpha: 0.5)
                              : whiteColor,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: greyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 Sliding Page Indicators
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Builder(
              builder: (context) {
                const int maxVisibleIndicators = 7;

                int startIndex;
                int endIndex;

                if (totalPages <= maxVisibleIndicators) {
                  startIndex = 0;
                  endIndex = totalPages;
                } else {
                  startIndex = (currentPageLocal - (maxVisibleIndicators ~/ 2))
                      .clamp(0, totalPages - maxVisibleIndicators);
                  endIndex = startIndex + maxVisibleIndicators;
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(endIndex - startIndex, (i) {
                    int actualIndex = startIndex + i;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (widget.controller == widget.scrollController1) {
                            widget.currentPage1 = actualIndex;
                          } else {
                            widget.currentPage = actualIndex;
                          }
                        });
                        widget.controller.animateTo(
                          actualIndex * itemsPerPage * itemWidthWithSpacing,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: currentPageLocal == actualIndex ? 10 : 6,
                        height: currentPageLocal == actualIndex ? 10 : 6,
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              currentPageLocal == actualIndex
                                  ? Colors.yellow.shade900
                                  : Colors.grey.shade300,
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
