import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customeTextField({
  String? title,
  String? hint,
  AutovalidateMode? autovalidateMode,
  String? Function(String?)? validator,
  void Function(String?)? onSaved,
  void Function(String)? onChanged,
  controller,
  isPass,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(greyColor).fontWeight(FontWeight.w500).size(16).make(),
      5.heightBox,
      TextFormField(
        onChanged: onChanged,
        obscureText: isPass,
        controller: controller,
        autovalidateMode: autovalidateMode,
        validator: validator,
        onSaved: onSaved,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: greyColo1),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: greyColo1),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}

Widget customeTextFiled1({
  String? hintText,
  required String labelText,
  TextEditingController? controller,
  void Function(String)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelText,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: greyColor,
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        onChanged: onChanged,
        controller: controller,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: blackColor2,
        ),

        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: greyColo1,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          //enabled: true,
        ),
      ),
    ],
  );
}
