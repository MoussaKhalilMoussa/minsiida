import 'package:flutter/material.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customeTextField({String? title, String? hint, controller, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(greyColor).fontWeight(FontWeight.w500).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: greyColo1),
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
