import 'package:flutter/material.dart';

class MarketHomePage extends StatelessWidget {
  const MarketHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              const SizedBox(height: 20),
              _sectionHeader("Nos annonces recommandées"),
              _horizontalList(),
              const SizedBox(height: 20),
              _sectionHeader("Annonces tendances populaires"),
              _horizontalList(),
              const SizedBox(height: 20),
              _footerSections(),
            ],
          ),
        ),
      ),
    );
  }

 
  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        TextButton(onPressed: () {}, child: const Text("Voir plus d'annonces")),
      ],
    );
  }

  Widget _horizontalList() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 140,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),
                const Text("Titre de l'annonce", maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                const Text("Ville", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                const Text("Prix €", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
        separatorBuilder: (context, _) => const SizedBox(width: 12),
      ),
    );
  }
  
  
  
  Widget _footerSections() {
    final sections = [
      "CATÉGORIES POPULAIRES",
      "NOTRE SITE",
      "SERVICES AUTO",
      "SUIVEZ-NOUS",
      "À PROPOS DU SITE",
      "INFORMATIONS LÉGALES",
      "NOS SOLUTIONS PROS",
      "DES QUESTIONS ?"
    ];

    return Column(
      children: sections.map((title) {
        return ExpansionTile(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Contenu de $title"),
            )
          ],
        );
      }).toList(),
    );
  }
}
