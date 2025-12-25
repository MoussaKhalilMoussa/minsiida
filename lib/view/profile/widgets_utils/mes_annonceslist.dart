import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/common_widgets/shimmer_container.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';
import 'package:simple_nav_bar/models/post.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/product_card.dart';

class MesAnnonceslist extends StatelessWidget {
  const MesAnnonceslist({super.key, required this.postController});

  final PostController postController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return postController.myAddsLoading.value
          ? Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            width: MediaQuery.sizeOf(Get.context!).width,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              ShimmerContainer(
                                padding: EdgeInsets.all(6),
                                height: 100,
                                width: 100,
                                borderRadius: 8,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerContainer(height: 15, width: 220),
                                    SizedBox(height: 5.h),
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ShimmerContainer(height: 10, width: 80),
                                        SizedBox(width: 67.w),
                                        ShimmerContainer(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          height: 10,
                                          width: 70,
                                          borderRadius: 16,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ShimmerContainer(height: 10, width: 50),
                                        SizedBox(width: 67.w),
                                        ShimmerContainer(
                                          height: 10,
                                          width: 100,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1, color: Colors.grey[300]),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ShimmerContainer(
                                height: 15,
                                width: 50,
                                borderRadius: 8,
                              ),
                              ShimmerContainer(
                                height: 15,
                                width: 50,
                                borderRadius: 8,
                              ),
                              ShimmerContainer(
                                height: 15,
                                width: 50,
                                borderRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
          : postController.myAdds.isEmpty
          ? Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height / 3,
            ),
            child: Center(
              child: SizedBox(
                width: 200,
                child: Text(
                  "Vous n'avez pas encore poster une annonce",
                  textAlign: TextAlign.center,

                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
            ),
          )
          : Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            width: MediaQuery.sizeOf(Get.context!).width,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: postController.filteredAdds.length,
              itemBuilder: (context, index) {
                Post post = postController.filteredAdds[index];
                return ProductCard(
                  id: post.id!,
                  imageUrl: post.mediaUrls!.first.content!,
                  title: post.title!,
                  price: post.price!.toString(),
                  status: post.status!.name,
                  date: formatShortDateNumber(post.date!.toString()),
                  view: post.views,
                );
              },
            ),
          );
    });
  }
}
