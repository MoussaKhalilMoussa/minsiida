import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_nav_bar/constants/colors.dart';

Widget otpBox({context, controller, required Function() callback}) {
  return SizedBox(
    height: 46.h,
    width: 43.w,
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorHeight: 20,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: greyColor),
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: greyColo1.withValues(alpha: 0.5),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: "_",
      ),
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
        callback();
      },

      style: Theme.of(context).textTheme.headlineLarge,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
  );
}
