import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            const Text(
              "Évaluation globale",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.h),
            Text(
              averageRating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
              style: const TextStyle(color: greyColor),
            ),
            SizedBox(height: 16.h),
            Column(
              children: List.generate(5, (index) {
                int star = 5 - index;
                double percent = ratingDistribution[star] ?? 0;
                return Row(
                  children: [
                    Text("$star ★", style: TextStyle(color: greyColor)),
                    SizedBox(width: 6.w),
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
                    Text(
                      "${percent.toStringAsFixed(0)}%",
                      style: TextStyle(color: greyColor),
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
