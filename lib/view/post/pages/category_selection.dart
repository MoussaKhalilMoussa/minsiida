import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/lists.dart';

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
  late int currentPage;
  int selectedCategoryIndex = -1; // or 0, depending on your logic


  @override
  void initState() {
    super.initState();
    currentPage = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header section with title and progress bar parent
              // This section is fixed at the top of the screen
              Align(
                //alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.only(top: 14),
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  // This is the header section including the title and progress bar
                  child: Column(
                    children: [
                      SizedBox(
                        //padding: const EdgeInsets.symmetric(horizontal: 4),
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                widget.currentPage == 0
                                    ? SizedBox(height: 20)
                                    : SizedBox(
                                      //width: 20,
                                      height: 20,
                                      child: InkWell(
                                        onTap: () {
                                          if (widget.currentPage > 0) {
                                            widget.controller.previousPage(
                                              duration: Duration(
                                                milliseconds: 300,
                                              ),
                                              curve: Curves.easeInOut,
                                            );
                                            setState(() {
                                              currentPage--;
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          size: 16,
                                          color: blackColor,
                                        ),
                                      ),
                                    ),
                                Text(
                                  'Categorie',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${widget.currentPage + 1}/3',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: LinearProgressIndicator(
                          value: (widget.currentPage + 1) / 3,
                          backgroundColor: Colors.grey[300],
                          color: purple_600,
                          minHeight: 5,
                        ),
                      ),
                    ],
                  ),
                ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                      "Que vendez-vous ?",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blackColor2,
                      ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GridView.builder(
                      padding: const EdgeInsets.all(16),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.2,
                      ),
                      itemCount: categories1.length - 3,
                      itemBuilder: (context, index) {
                      final category = categories1[index];
                      final isSelected = selectedCategoryIndex == index;
                      return GestureDetector(
                        onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                        },
                        child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? purple_600 : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                          color: isSelected ? purple_600 : Colors.grey.shade300,
                          width: 2,
                          ),
                          boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                            category['icon'],
                            color: isSelected ? Colors.white : purple_600,
                            size: 24,
                            ),
                            const SizedBox(height: 8),
                            Text(
                            category['label'],
                            style: TextStyle(
                              color: isSelected ? Colors.white : blackColor2,
                              fontWeight: FontWeight.w600,
                            ),
                            ),
                          ],
                          ),
                        ),
                        ),
                      );
                      },
                    ),
                    ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
