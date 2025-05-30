import 'package:flutter/material.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? color;
  final Widget child;
  final double width, height;
  final double borderRadius;

  CustomButton({
    super.key,
    required this.onPressed,
    this.color, 
    required this.child,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [purple_600,indigo_600],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}