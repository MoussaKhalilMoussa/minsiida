import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/controllers/details_page_controller/details_page_controller.dart';
import 'package:simple_nav_bar/controllers/location_controller/location_controller.dart';
import 'package:simple_nav_bar/controllers/photo_controller/photos_controller.dart';
import 'package:simple_nav_bar/controllers/specifications/specification_controller.dart';
import 'package:simple_nav_bar/view/post/pages/category_selection.dart';
import 'package:simple_nav_bar/view/post/pages/delivery_page.dart';
import 'package:simple_nav_bar/view/post/pages/details_page.dart';
import 'package:simple_nav_bar/view/post/pages/photos_page.dart';
import 'package:simple_nav_bar/view/post/pages/specifications.dart';
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
  final detailsController = Get.find<DetailsPageController>();
  final locationController = Get.find<LocationController>();
  final specificationsController = Get.find<SpecificationController>();

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

    if (index == 2 &&
        (detailsController.titleController.text.trim().isEmpty ||
            detailsController.priceController.text.trim().isEmpty ||
            detailsController.descController.text.trim().isEmpty ||
            locationController.selectedCity.value == null ||
            locationController.selectedSubPrefecture.value.isEmpty)) {
      // detailsController.showDetailsError.value = true;

      if (detailsController.titleController.text.trim().isEmpty) {
        detailsController.showTitleError.value = true;
      }

      if (detailsController.priceController.text.trim().isEmpty) {
        detailsController.showPriceError.value = true;
      }

      if (detailsController.descController.text.trim().isEmpty) {
        detailsController.showDescriptionError.value = true;
      }

      if (locationController.selectedCity.value == null ||
          locationController.selectedSubPrefecture.value.isEmpty) {
        detailsController.showDetailsError.value = true;
      }
      detailsController.titleTouched.value = true;
      detailsController.priceTouched.value = true;
      detailsController.descTouched.value = true;
      return;
    }

    if (index == 3) {
      final model = specificationsController.selectedModel.value;
      final storage = specificationsController.selectedStorage.value;
      final color = specificationsController.selectedColor.value;
      final bateryState = specificationsController.selectedBateryState.value;
      final guarantee = specificationsController.selectedGuarantee.value;
      final condition = specificationsController.selectedCondition.value;

      specificationsController.showModelError.value = model == null;
      specificationsController.showStorageError.value = storage == null;
      specificationsController.showColorError.value = color == null;
      specificationsController.showBateryStateError.value = bateryState == null;
      specificationsController.showGuaranteeError.value = guarantee == null;
      specificationsController.showConditionError.value = condition == null;

      if (model == null ||
          storage == null ||
          color == null ||
          bateryState == null ||
          guarantee == null ||
          condition == null) {
        return;
      }
    }
    // Clear errors if vali dations pass
    controller.isError.value = false;
    categoryController.showCategoryError.value = false;
    detailsController.showDetailsError.value = false;
    // Move to next page if not last
    if (index < 5) {
      index++;
      _controller.animateToPage(
        index,
        duration: Duration(microseconds: 300),
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

                      DetailsPage(
                        currentPage: _currentPage,
                        index: index,
                        controller: _controller,
                      ),

                      Specifications(
                        currentPage: _currentPage,
                        index: index,
                        controller: _controller,
                      ),
                      DeliveryPage(
                        currentPage: _currentPage,
                        index: index,
                        controller: _controller,
                      ),
                      Center(child: Text("Page ")),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    borderRadius: 12,
                    onPressed: _goToPage,
                    width: MediaQuery.sizeOf(context).width * 0.9,
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
