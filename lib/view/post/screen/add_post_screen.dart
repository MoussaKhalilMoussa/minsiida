import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/getx_controllers/photos_controller.dart';
import 'package:simple_nav_bar/view/post/pages/category_selection.dart';
import 'package:simple_nav_bar/view/post/pages/photos_page.dart';
import 'package:simple_nav_bar/view/post/widget/continue_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final PageController _controller = PageController(keepPage: true);
  int _currentPage = 0;
  int index = 0;
  var controller = Get.put(PhotosController());

  void _goToPage() {
    if (controller.selectedImages.isEmpty) {
      controller.isError.value = true;
      return;
    }
    controller.isError.value = false;
    if (index < 2) {
      // You have 3 pages: 0, 1, 2
      index++;
      _controller.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = index;
      });
    } else {
      // If you are on the last page, you can handle it here
      // For example, you might want to submit the form or show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vous avez atteint la dernière page.")),
      );
    }
  }

  Map<Map<String, dynamic>, Map<String, Widget>> pages = {
    {'title': 'Page 2'}: {'content': Center(child: Text("page 2"))},
    {'title': 'Page 3'}: {'content': Center(child: Text("page 3"))},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        shadowColor: Colors.grey.withValues(alpha: 1),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            controller.selectedImages.clear();
            controller.isError.value = false;
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Publier une annonce',
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  // Wrap in Obx so we rebuild when isError changes
                  child: PageView(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged:
                        (p) => setState(() {
                          _currentPage = p;
                          index = p;
                        }),
                    children: [
                      PhotosPage(
                        controller: _controller,
                        currentPage: _currentPage,
                        index: index,
                      ),
                      CategorySelection(currentPage: _currentPage, index: index, controller: _controller),
                      Center(child: Text("Page 3")),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    borderRadius: 12,
                    onPressed: _goToPage,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Continuer ",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
