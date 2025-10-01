import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/common_widgets/breadcrump.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/view/categories/models/category.dart';

class CategorySelection extends StatefulWidget {
  final int currentPage;
  final int index;
  final PageController controller;
  const CategorySelection({
    super.key,
    required this.currentPage,
    required this.index,
    required this.controller,
  });

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  final controller = Get.find<CategoryContorller>();
  late int currentPage;
  //int selectedCategoryIndex = -1; // or 0, depending on your logic

  // error message for no category selected

  Widget _errorMessage() {
    return Obx(() {
      return controller.showCategoryError.value
          ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red.withValues(alpha: 0.5),
                  width: 1.5,
                ),
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "ⓘ Veuillez sélectionner une catégorie.",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          : const SizedBox.shrink();
    });
  }

  @override
  void initState() {
    super.initState();
    currentPage = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    //final screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header section with title and progress bar parent
              // This section is fixed at the top of the screen
              Breadcrump(
                title: "Categorie",
                currentPage: widget.currentPage,
                controller: widget.controller,
                //categoryFunction: controller.clear(),
              ),
              const SizedBox(height: 30),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: screenW * 0.9,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Que vendez-vous ?",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: blackColor2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(child: _errorMessage()),

                    GridView.builder(
                      padding: const EdgeInsets.all(16),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.2,
                          ),
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        return Obx(() {
                          final isSelected =
                              controller.selectedCategoryIndex.value == index;
                          return GestureDetector(
                            onTap: () {
                              controller.selectedCategoryIndex.value = index;
                              controller.showCategoryError.value = false;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected ? purple_600 : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? purple_600
                                          : Colors.grey.shade300,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      category.icon!,
                                      style: GoogleFonts.poppins(fontSize: 24),
                                    ),
                                    /* Icon(
                                      category['icon'],
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : purple_600,
                                      size: 24,
                                    ), */
                                    const SizedBox(height: 8),
                                    Text(
                                      category.name!,
                                      style: GoogleFonts.poppins(
                                        color:
                                            isSelected
                                                ? Colors.white
                                                : blackColor2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Obx(() {
                      final index = controller.selectedCategoryIndex.value;
                      if (index < 0 || index >= categoriesSelection.length) {
                        return const SizedBox.shrink();
                      }

                      final Category selectedCategory =
                          controller.categories[index];
                      final List<Subcategory>? subcategories =
                          selectedCategory.subcategories;

                      if (subcategories == null || subcategories.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selectioner une sous-catégories",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: blackColor2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(subcategories.length, (
                                index,
                              ) {
                                final sub = subcategories[index];
                                return Obx(() {
                                  final isSelected =
                                      controller.selectedSubcategory.value ==
                                      sub.name;
                                  return ChoiceChip(
                                    label: Text(
                                      sub.name!,
                                      style: GoogleFonts.poppins(),
                                    ),
                                    selected: isSelected,
                                    onSelected:
                                        (_) =>
                                            controller
                                                .selectedSubcategory
                                                .value = sub.name!,
                                    selectedColor: purple_600,
                                    labelStyle: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black87,
                                    ),
                                  );
                                });
                              }),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
