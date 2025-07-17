import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';

ListTile listTitle({
  required String title,
  String? subtitle,
  required IconData leadingIcon,
  required IconData trailingIcon,
  Color color = greyColo1,
  Function()? onTap,
  bool selected = false,
}) {
  return ListTile(
    selected: selected,
    selectedTileColor: greyColo1.withValues(
      alpha: 0.1,
    ), // Optional background on select
    iconColor: selected ? blueColor : color,
    textColor: selected ? blueColor : blackColor2,
    leading: Icon(leadingIcon),
    title: Text(
      title,
      style: GoogleFonts.playfairDisplay(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    ),
    trailing: Icon(trailingIcon),
    onTap: onTap,
  );
}
