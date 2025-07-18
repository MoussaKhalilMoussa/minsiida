import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/common_widgets/breadcrump.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/delivery_controller/delivery_controller.dart';
import 'package:simple_nav_bar/controllers/details_page_controller/details_page_controller.dart';
import 'package:simple_nav_bar/controllers/location_controller/location_controller.dart';
import 'package:simple_nav_bar/controllers/photo_controller/photos_controller.dart';
import 'package:simple_nav_bar/controllers/specifications/specification_controller.dart';
import 'package:simple_nav_bar/view/post/widget/continue_button.dart';

class SummaryPage extends StatefulWidget {
  final int currentPage;
  final int index;
  final PageController controller;
  const SummaryPage({
    super.key,
    required this.currentPage,
    required this.index,
    required this.controller,
  });

  @override
  State<SummaryPage> createState() => _SummaryPage();
}

class _SummaryPage extends State<SummaryPage> {
  late int currentPage;
  final deliveryController = Get.find<DeliveryController>();
  final locationController = Get.find<LocationController>();
  final specificationController = Get.find<SpecificationController>();
  final detailsController = Get.find<DetailsPageController>();
  final photoController = Get.find<PhotosController>();
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
                  title: "Appercy",
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
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                            "Aperçu de Votre Annonce",
                            style: GoogleFonts.playfairDisplay(
                              color: blackColor2,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(14),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: greyColo1, width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // this container wil hold the image
                              Container(
                                width: screenW,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  color: greyColo1.withValues(alpha: 0.1),
                                ),
                                child: Obx(() {
                                  if (photoController.selectedImages.isEmpty) {
                                    return const Center(
                                      child: Text("No images selected"),
                                    );
                                  }
                                  return Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children:
                                        photoController.selectedImages.map((
                                          image,
                                        ) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.file(
                                              File(image.path),
                                              width: screenW / 4.19,
                                              height: screenH / 10,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }).toList(),
                                  );
                                }),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                  top: 8,
                                  right: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Some text",
                                      style: GoogleFonts.playfairDisplay(
                                        color: blackColor2,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(2),
                                      width: 100,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: greyColo1.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            size: 15,
                                            color: greyColo1,
                                          ),
                                          Text("À l'instant "),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  "150€",
                                  style: GoogleFonts.playfairDisplay(
                                    color: purple_600,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8, top: 8),
                                child: Container(
                                  //padding: EdgeInsets.all(2),
                                  width: 200,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: greyColo1.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    spacing: 10,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 15,
                                        color: purple_600,
                                      ),
                                      Text("Les Carmes, Toulouse "),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4,
                                ),
                                child: Divider(),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Row(
                                  spacing: 6,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Icon(
                                      LucideIcons.tag,
                                      size: 15,
                                      color: purple_600,
                                    ),
                                    Text(
                                      "Détails de l'Article",
                                      style: GoogleFonts.playfairDisplay(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              showItem(
                                title1: "Modèle",
                                title2: "Stockage",
                                content1:
                                    specificationController
                                        .filteredModels
                                        .first,
                                content2:
                                    specificationController
                                        .filteredStorage
                                        .first,
                                spacing: screenW,
                              ),

                              showItem(
                                title1: "Couleur",
                                title2: "État",
                                content1:
                                    specificationController
                                        .filteredColors
                                        .first,
                                content2:
                                    specificationController
                                        .filteredConditions
                                        .first,
                                spacing: screenW,
                              ),

                              showItem(
                                title1: "Garantie",
                                title2: "Batterie",
                                content1:
                                    specificationController
                                        .filteredGuarantees
                                        .first,
                                content2:
                                    specificationController
                                        .filteredBateryStates
                                        .first,
                                spacing: screenW,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4,
                                ),
                                child: Divider(),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Row(
                                  spacing: 6,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    /* Icon(
                                      LucideIcons.tag,
                                      size: 15,
                                      color: purple_600,
                                    ), */
                                    Text(
                                      "Description",
                                      style: GoogleFonts.playfairDisplay(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 0,
                                  color: const Color.fromARGB(
                                    255,
                                    249,
                                    252,
                                    255,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 10,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 4),
                                              Text(
                                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",

                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,

                                                  color: blackColor2,
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

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 0,
                                  color: const Color.fromARGB(
                                    255,
                                    230,
                                    243,
                                    255,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 10,
                                      children: [
                                        // Left side: Texts
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors
                                                    .white, // Outer white border
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(
                                            4,
                                          ), // 4px spacing inside
                                          child: ClipOval(
                                            child: Image.network(
                                              "https://cdn.pixabay.com/photo/2024/06/22/23/01/boy-8847075_1280.jpg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        // Right side: Checkbox-like icon area
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Votre Nom",
                                                style:
                                                    GoogleFonts.playfairDisplay(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: blackColor2,
                                                    ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "Membre depuis 2023",
                                                style:
                                                    GoogleFonts.playfairDisplay(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                      color: greyColo1,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 50,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            color: Colors.green.withValues(
                                              alpha: 0.1,
                                            ),
                                          ),
                                          child: Text(
                                            "Vérifié",
                                            style: GoogleFonts.playfairDisplay(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: CustomButton(
                            onPressed: () {
                              
                            },
                            width: screenW * 0.83,
                            height: screenH / 18,
                            borderRadius: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.print_outlined,
                                  color: whiteColor,
                                  size: 24,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Publier l'Anonce",
                                  style: GoogleFonts.playfairDisplay(
                                    color: whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: greyColo1.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "En publiant cette annonce, vous acceptez nos",
                                  style: GoogleFonts.playfairDisplay(
                                    color: blackColor2,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  " Conditions d'Utilisation",
                                  style: GoogleFonts.playfairDisplay(
                                    color: purple_600,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  "et",
                                  style: GoogleFonts.playfairDisplay(
                                    color: blackColor2,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  "Règles de la Communauté",
                                  style: GoogleFonts.playfairDisplay(
                                    color: purple_600,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showItem({
    required String title1,
    required String title2,
    required String content1,
    required String content2,
    required double spacing,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        spacing: 4,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title1,
                style: GoogleFonts.playfairDisplay(
                  color: greyColo1,
                  fontSize: 9,
                ),
              ),
              SizedBox(width: spacing / 10),
              SizedBox(
                width: 80, // or any fixed width you prefer
                child: Text(
                  //maxLines: 7,
                  //overflow: TextOverflow.ellipsis,
                  truncateWithEllipsis(content1, 20),
                  textAlign: TextAlign.right,
                  style: GoogleFonts.playfairDisplay(
                    color: blackColor2,
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              SizedBox(
                width: 60, // match width with above
                child: Text(
                  title2,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.playfairDisplay(
                    color: greyColo1,
                    fontSize: 9,
                  ),
                ),
              ),
              SizedBox(width: spacing / 16),
              SizedBox(
                width: 60,
                child: Text(
                  textAlign: TextAlign.right,
                  content2,
                  style: GoogleFonts.playfairDisplay(
                    color: blackColor2,
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String truncateWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    if (maxLength <= 3) return text.substring(0, maxLength);
    return '${text.substring(0, 16)}...';
  }
}
