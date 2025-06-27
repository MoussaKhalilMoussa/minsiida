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
}) {
  return ListTile(
    leading: Icon(leadingIcon, color: color),
    title: Text(title, style: GoogleFonts.playfairDisplay(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: blackColor2)),
    //subtitle: Text(subtitle!),
    trailing: Icon(trailingIcon, color:color),
    //contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    onTap: onTap,
  );
}
