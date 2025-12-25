import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.padding,
    this.margin,
    this.child,
  });
  final double? height, width;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding, margin;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: shimmmerBaseColor!,
      highlightColor: shimmerhighlightColor!,
      child: Container(
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          color: shimmmerBaseColor,
        ),
        child: child,
      ),
    );
  }
}
