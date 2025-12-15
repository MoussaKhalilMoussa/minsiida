import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';

class ShowCategoryNameAndLength extends StatelessWidget {
  final CategoryContorller categoryController;
  final PostController postController;
  final bool isLoading;

  const ShowCategoryNameAndLength({
    super.key,
    required this.categoryController,
    required this.postController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
          baseColor: shimmmerBaseColor!,
          highlightColor: shimmerhighlightColor!,
          child: Container(
            margin: EdgeInsets.all(0),
            height: 25.0,
            width: 180.0,
            color: shimmmerBaseColor,
          ),
        )
        : Text(
          "${categoryController.selectedCategoryName.value}"
          " - ${postController.totalElements.value} "
          "annonce${postController.totalElements.value > 1 ? 's trouvées' : ' trouvée'}",
          style: GoogleFonts.poppins(
            color: blackColor2,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        );
  }
}
