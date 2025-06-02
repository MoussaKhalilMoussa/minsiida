import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/controllers/photo_controller/photos_controller.dart';
import 'package:simple_nav_bar/view/post/pages/category_selection.dart';
import 'package:simple_nav_bar/view/post/pages/details_page.dart';
import 'package:simple_nav_bar/view/post/pages/photos_page.dart';
import 'package:simple_nav_bar/view/post/widget/continue_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final PageController _controller = PageController(keepPage: true);
  final controller = Get.put(PhotosController());
  final categoryController = Get.put(CategoryContorller());

  int _currentPage = 0;
  int index = 0;

  void _goToPage() {
    // Page 0: Validate photos
    if (index == 0 && controller.selectedImages.isEmpty) {
      controller.isError.value = true;
      return;
    }

    // Page 1: Validate category selection
    if (index == 1 && categoryController.selectedCategoryIndex.value == -1) {
      categoryController.showCategoryError.value = true;
      return;
    }

    // Clear errors if validations pass
    controller.isError.value = false;
    categoryController.showCategoryError.value = false;

    // Move to next page if not last
    if (index < 2) {
      index++;
      _controller.animateToPage(
        index,
        duration: Duration(milliseconds: 50),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = index;
      });
    } else {
      // Final action
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
            categoryController.selectedCategoryIndex.value = -1;
            categoryController.showCategoryError.value = false;
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
                      CategorySelection(
                        currentPage: _currentPage,
                        index: index,
                        controller: _controller,
                      ),

                      DetailsPage(currentPage: _currentPage, index: index, controller: _controller),
                      Center(child: Text("Page ")),
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
