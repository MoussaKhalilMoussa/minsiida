import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';

Widget subTitle({
required String title, 
Function()? onTap,
Widget? leading,
Widget? trailing
}) {
  return ListTile(
    trailing:trailing ,
    leading: leading,
    title: Text(
      title,
      style: GoogleFonts.playfairDisplay(color: blackColor2),
    ),
    onTap: onTap,
  );
}
