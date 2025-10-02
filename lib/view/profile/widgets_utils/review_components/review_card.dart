import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final String reviewDate;
  final double rating;
  final String reviewText;
  final String productName;

  const ReviewCard({
    super.key,
    required this.userName,
    required this.reviewDate,
    required this.rating,
    required this.reviewText,
    required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      //elevation: 1,
      color: whiteColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: greyColo1.withValues(alpha: .3)
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      //margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: avatar + name + date
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.purple,
                  child: Text(
                    userName.isNotEmpty ? userName[0] : "?",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < rating
                                ? Icons.star
                                : Icons.star_border_outlined,
                            color: Colors.amber,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  reviewDate,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Review Text
            Text(reviewText, style: GoogleFonts.poppins(fontSize: 14)),

            SizedBox(height: 12.h),

            // Product Info
            Text(
              "Produit : $productName",
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
