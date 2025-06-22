import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';

class Favorites extends StatefulWidget {
  final VoidCallback? closeFavorites;
  final Animation<Offset> offsetAnimation;

  const Favorites({
    super.key,
    required this.closeFavorites,
    required this.offsetAnimation,
  });

  @override
  State<Favorites> createState() => _Favorites();
}

class _Favorites extends State<Favorites>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  var isVehiculesOpen = false;

  final categoryController = Get.find<CategoryContorller>();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }


  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.offsetAnimation,
      child: Material(
        color: Colors.white,
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: Text(
                      "Favorites",
                      style: GoogleFonts.playfairDisplay(
                        //fontWeight: FontWeight.bold,
                        color: greyColor,
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.close, color: blackColor2),
                        onPressed: widget.closeFavorites,
                      ),
                    ],
                  ),
                 ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
