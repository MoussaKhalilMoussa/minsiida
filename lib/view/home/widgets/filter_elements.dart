import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/strings.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';

Widget filterElements() {
  final categoryItems = [
    {"model": "iphone iOS", "number": "127.787"},
    {"model": "Android", "number": "112.753"},
    {"model": "Accessoires Teleohone", "number": "46.711"},
    {"model": "Autres Telephones", "number": "14.075"},
    {"model": "Pieces Detachees", "number": "12.201"},
    {"model": "Telephones Fixes", "number": "5.547"},
  ];

  final homeController = Get.find<HomeController>();
  return Obx(() {
    final isSelected = homeController.selectedSubCategory.value == "Telephones";
    return Column(
      children: [
        Column(
          children: [
            ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                "Categories",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    bottom: 8.0,
                    left: 24.0,
                  ),
                  child: Container(
                    width: MediaQuery.sizeOf(Get.context!).width * 0.88,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Colors.grey.shade200
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: purple_600,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Icon(
                            LucideIcons.phone,
                            color: whiteColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            homeController.selectedSubCategory.value =
                                "Telephones";
                          },
                          child: Text(
                            "Telephones",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: blackColor2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    right: 26.0,
                    top: 0.0,
                    bottom: 8.0,
                    left: 60.0,
                  ),
                  child: Column(
                    spacing: 6,
                    children:
                        categoryItems.map((item) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  homeController.selectedSubCategory.value =
                                      item["model"]!;
                                },
                                child: Text(
                                  item["model"]!,
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        homeController
                                                    .selectedSubCategory
                                                    .value ==
                                                item["model"]
                                            ? Colors.blue
                                            : blackColor2,
                                  ),
                                ),
                              ),
                              Text(
                                "(${item['number']!})",
                                style: GoogleFonts.playfairDisplay(
                                  color: blackColor2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Column with two Text widgets
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title Text',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Subtitle Text',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),

                  // Toggle Button
                  // Toggle Button with GetX
                  Obx(
                    () => Switch(
                      trackOutlineWidth: WidgetStateProperty.all(0),
                      activeTrackColor: primaryColor,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: primaryColor.withValues(alpha: 0.1),
                      //activeColor: primaryColor,
                      value: homeController.isSelected.value,
                      //isSelected: [homeController.isSelected.value],
                      onChanged: (_) => homeController.toggle(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  });
}
