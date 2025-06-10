import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/common_widgets/breadcrump.dart';

class DeliveryPage extends StatefulWidget {
  final int currentPage;
  final int index;
  final PageController controller;
  const DeliveryPage({
    super.key,
    required this.currentPage,
    required this.index,
    required this.controller,
  });

  @override
  State<DeliveryPage> createState() => _DeliveryPage();
}

class _DeliveryPage extends State<DeliveryPage> {
  late int currentPage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  

  @override
  void initState() {
    super.initState();
    currentPage = widget.currentPage;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.sizeOf(Get.context!).width;
    final screenH = MediaQuery.sizeOf(Get.context!).height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header section with title and progress bar parent
                // This section is fixed at the top of the screen
                Breadcrump(
                  title: "Livraison",
                  currentPage: widget.currentPage,
                  controller: widget.controller,
                ),
                const SizedBox(height: 30),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: screenW * 0.9,
                  //height: totalHeight,
                  //constraints: BoxConstraints(minHeight: totalHeight - 4),
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.grey.withValues(alpha: 0.2),
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  // And inside, we stack picker UI + images:
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [const SizedBox(height: 8)],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
