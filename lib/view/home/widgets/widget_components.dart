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
            TextButton(
              onPressed: () {},
              child: const Text("Voir plus \nd'annonces"),
            ),
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
    children:
        sections.map((title) {
          return ExpansionTile(
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Contenu de $title"),
              ),
            ],
          );
        }).toList(),
  );
}

