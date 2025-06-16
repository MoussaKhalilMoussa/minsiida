import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';


Widget filterElements() {
  final sections = [
    "CATÉGORIES POPULAIRES",
    "NOTRE SITE",
    "SERVICES AUTO",
    "SUIVEZ-NOUS",
    "À PROPOS DU SITE",
    "INFORMATIONS LÉGALES",
    "NOS SOLUTIONS PROS",
    "DES QUESTIONS ?",
  ];

  final homeController = Get.find<HomeController>();
  return Column(
    children: [
      Column(
        children:
            sections.map((title) {
              if (title == "NOTRE SITE") {
                return Container(
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
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
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
                          inactiveTrackColor: primaryColor.withValues(
                            alpha: 0.1,
                          ),
                          //activeColor: primaryColor,
                          value: homeController.isSelected.value,
                          //isSelected: [homeController.isSelected.value],
                          onChanged: (_) => homeController.toggle(),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ExpansionTile(
                expandedAlignment: Alignment.centerLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                title: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      top: 0.0,
                      bottom: 8.0,
                      left: 16.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Contenu de $title",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 12,
                            color: greyColo1,
                          ),
                        ),
                        Text(
                          "Contenu de $title",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 12,
                            color: greyColo1,
                          ),
                        ),
                        Text(
                          "Contenu de $title",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 12,
                            color: greyColo1,
                          ),
                        ),
                        Text(
                          "Contenu de $title",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 12,
                            color: greyColo1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
      SizedBox(height: 24),
      
    ],
  );
}
