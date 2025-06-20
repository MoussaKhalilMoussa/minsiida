import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';

Widget sectionHeader(String title) {
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
            TextButton(onPressed: () {}, child: Text("Voir plus \nd'annonces")),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios, size: 12, color: greyColor),
            ),
          ],
        ),
      ],
    ),
  );
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
      Text(
        "Liens officiels",
        style: GoogleFonts.playfairDisplay(fontSize: 12, color: blackColor2),
      ),
      SizedBox(height: 10),

      Text(
        "Conditions générales - Politique publicitaire",
        style: GoogleFonts.playfairDisplay(fontSize: 12, color: blackColor2),
      ),
      SizedBox(height: 8),

      Text(
        "Guide pour institutions officielles - Politique de confidentialité",
        style: GoogleFonts.playfairDisplay(fontSize: 12, color: blackColor2),
      ),
      SizedBox(height: 10),
      Text(
        "© 2006-2025 - Tous droits réservés",
        style: GoogleFonts.playfairDisplay(fontSize: 12, color: greyColo1),
      ),
    ],
  );
}
