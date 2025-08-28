import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  Animation<Offset> get offsetAnimation => _offsetAnimation;

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void closeFilter() {
    _controller.reverse();
  }
}
