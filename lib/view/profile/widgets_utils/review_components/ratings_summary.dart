import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class RatingSummary extends StatelessWidget {
  final double averageRating;
  final int totalReviews;
  final Map<int, double> ratingDistribution;

  const RatingSummary({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: greyColo1.withValues(alpha: 0.1),
      ),

      //elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Évaluation globale",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              averageRating.toStringAsFixed(1),
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                int starIndex = index + 1;
                return Icon(
                  Ionicons.star,
                  color:
                      averageRating >= starIndex
                          ? Colors.amber
                          : averageRating >= starIndex - 0.5
                          ? Colors.amberAccent
                          : Colors.grey[300],
                );
              }),
            ),
            SizedBox(height: 4.h),
            Text(
              "Basé sur $totalReviews avis",
              style: GoogleFonts.poppins(color: greyColor),
            ),
            SizedBox(height: 16.h),
            Column(
              children: List.generate(5, (index) {
                int star = 5 - index;
                double percent = ratingDistribution[star] ?? 0;
                return Row(
                  children: [
                    SizedBox(
                      width: 60, // ✅ fixed width so alignment doesn't shrink
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // ✅ align right
                        children: [
                          Text(
                            "$star",
                            style: GoogleFonts.poppins(color: greyColor),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "★",
                            style: GoogleFonts.poppins(color: greyColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: percent / 100,
                        color: Colors.amber,
                        backgroundColor: greyColo1.withValues(alpha: 0.3),
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    SizedBox(
                      width: 50,
                      child: Text(
                        "${percent.toStringAsFixed(0)}%",
                        style: GoogleFonts.poppins(color: greyColor),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
