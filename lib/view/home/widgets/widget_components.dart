import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.title2});

  final String title;
  final String? title2;

  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());
    final homeController = Get.find<HomeController>();
    var categoryController = Get.find<CategoryContorller>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mainMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  homeController.homeIndex.value = 1;
                  switch (title2) {
                    case "vedette":
                      categoryController.selectedCategoryName.value = "vedette";
                      await postController.getFeaturedPosts();

                      break;
                    case "recommandees":
                      categoryController.selectedCategoryName.value =
                          "recommandees";
                      await postController.getSuggestedPosts();
                      break;
                    case "populaires":
                      categoryController.selectedCategoryName.value =
                          "populaires";
                      await postController.getTrendingPosts();
                      break;
                  }
                },
                child: Text("Voir plus \nd'annonces"),
              ),
              IconButton(
                onPressed: () async {
                  homeController.homeIndex.value = 1;
                  switch (title2) {
                    case "vedette":
                      categoryController.selectedCategoryName.value = "vedette";
                      await postController.getFeaturedPosts();
                      break;
                    case "recommandees":
                      categoryController.selectedCategoryName.value =
                          "recommandees";
                      await postController.getSuggestedPosts();
                      break;
                    case "populaires":
                      categoryController.selectedCategoryName.value =
                          "populaires";
                      await postController.getTrendingPosts();
                      break;
                  }
                },
                icon: Icon(Icons.arrow_forward_ios, size: 12, color: greyColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget footerSections() {
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

  return Column(
    children: [
      Column(
        children:
            sections.map((title) {
              return ExpansionTile(
                expandedAlignment: Alignment.centerLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                title: Text(
                  title,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
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
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: greyColo1,
                          ),
                        ),
                        Text(
                          "Contenu de $title",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: greyColo1,
                          ),
                        ),
                        Text(
                          "Contenu de $title",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: greyColo1,
                          ),
                        ),
                        Text(
                          "Contenu de $title",
                          style: GoogleFonts.poppins(
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
      Text(
        "Liens officiels",
        style: GoogleFonts.poppins(fontSize: 10, color: blackColor2),
      ),
      SizedBox(height: 10),

      Text(
        "Conditions générales - Politique publicitaire",
        style: GoogleFonts.poppins(fontSize: 10, color: blackColor2),
      ),
      SizedBox(height: 8),

      Text(
        "Guide pour institutions officielles - Politique de confidentialité",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(fontSize: 10, color: blackColor2),
      ),
      SizedBox(height: 10),
      Text(
        "© 2006-2025 - Tous droits réservés",
        style: GoogleFonts.poppins(fontSize: 10, color: greyColo1),
      ),
    ],
  );
}
