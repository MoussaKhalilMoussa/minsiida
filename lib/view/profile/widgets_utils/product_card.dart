import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/common_widgets/price_widget.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  //final bool isSold;
  final String status;
  final String date;
  final int view;
  final int? id;

  const ProductCard({
    super.key,
    this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.status,
    required this.date,
    required this.view,
    required,
  });

  @override
  Widget build(BuildContext context) {
    final postController = Get.find<PostController>();
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shortTruncateWithEllipsis(title),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5.h),

                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 130.w),
                          child: PriceWidget(
                            price: price, // even single digit
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: blackColor2,
                            compact: false,
                          ),
                        ),
                        SizedBox(width: 25.w),
                        Container(
                          width: 70.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            status.toLowerCase(),
                            style: GoogleFonts.poppins(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.eye_outline,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5.h),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 85.w,
                          ), // forces min width
                          child: Text(
                            '$view ${view < 2 ? "vu" : "vus"}', // even single digit
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 30.w),
                        Icon(
                          Ionicons.calendar_outline,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          date,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: 1, color: Colors.grey[300]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Row(
                  children: [
                    Icon(Ionicons.eye_outline, color: primaryColor),
                    SizedBox(width: 5),
                    Text(
                      'View',
                      style: GoogleFonts.poppins(color: primaryColor),
                    ),
                  ],
                ),
                onPressed: () {
                  // View action
                  // TODO: View product
                },
              ),
              IconButton(
                icon: Row(
                  children: [
                    Icon(Ionicons.create_outline, color: Colors.green),
                    SizedBox(width: 5),
                    Text(
                      'Edit',
                      style: GoogleFonts.poppins(color: Colors.green),
                    ),
                  ],
                ),
                onPressed: () {
                  // Edit action
                  // TODO: edit action
                },
              ),
              IconButton(
                icon: Row(
                  children: [
                    Icon(Ionicons.trash_outline, color: Colors.red),
                    SizedBox(width: 5),
                    Text(
                      'Delete',
                      style: GoogleFonts.poppins(color: Colors.red),
                    ),
                  ],
                ),
                onPressed: () {
                  postController.deletePost(postId: id!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
