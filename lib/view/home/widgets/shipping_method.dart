import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';

Widget shippingMethod({
  required String icon,
  required String title,
  required String subTitle,
  required String price,
}) {
  return Container(
    width: MediaQuery.sizeOf(Get.context!).width,
    height: 80,
    decoration: BoxDecoration(
      color: greyColo1.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(icon, style: GoogleFonts.poppins(fontSize: 24)),
              ],
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(Get.context!).width * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: blackColor2,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subTitle,
                    style: GoogleFonts.poppins(
                      color: greyColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 4,),
            Text(
              textAlign: TextAlign.end,
              price,
              style: GoogleFonts.poppins(
                color: blackColor2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
