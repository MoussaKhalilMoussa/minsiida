import 'package:flutter/material.dart';

Widget ourButton({onPressed, color, required Widget child}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPressed,
    child: child,
  );
}
/// title!.text.color(textColor).fontWeight(FontWeight.bold).make()