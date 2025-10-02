import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/common_widgets/price_widget.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/p1.jpeg',
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Iphone 14 Pro Max',
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
                          constraints: BoxConstraints(
                            minWidth: 130.w
                          ),
                          child: PriceWidget(
                            price: "3000000", // even single digit
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
                            'vendue',
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
                            '1349889 vus', // even single digit
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
                          '2025-01-01',
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
                  // Edit action
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
                  // Delete action
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
                  // Delete action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
