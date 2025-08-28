import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget notificationTab({
  required void Function()? onTap,
  required String label,
  required Color? color,
  required Color? backgroundColor,
  Widget? avatar,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Chip(
      //labelPadding: const EdgeInsets.symmetric(horizontal: 2),
      avatar: avatar,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      label: Text(
        label,
        style: GoogleFonts.playfairDisplay(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
