import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class BaseDeConnaissances extends StatefulWidget {
  const BaseDeConnaissances({super.key});

  @override
  State<BaseDeConnaissances> createState() => _BaseDeConnaissancesState();
}

class _BaseDeConnaissancesState extends State<BaseDeConnaissances> {
  // Track expansion state for each panel
  final List<bool> _isExpandedList = [false, false];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: purple_600.withValues(alpha: .1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Ionicons.help_circle_outline,
                size: 20,
                color: purple_600,
              ),
            ),
            title: Text(
              'Base de connaissances',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: blackColor2,
              ),
            ),
            horizontalTitleGap: 8,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
          ),
          const Divider(height: 1),

          /// FIX ✅
          ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 500),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpandedList[index] = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                isExpanded: _isExpandedList[0],
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const ListTile(
                    title: Text('Comment puis-je mettre un article en vente ?'),
                  );
                },
                body: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    '''Pour mettre un article en vente, rendez-vous sur 
                       votre tableau de bord et cliquez sur "Publier une annonce"
                       dans le menu de navigation. Remplissez le formulaire d'annonce 
                       avec les détails de votre article, y compris le titre, la description, 
                       le prix et les photos. Une fois que vous êtes satisfait, cliquez sur "Publier l'annonce" 
                       pour rendre votre article visible aux acheteurs potentiels.''',
                  ),
                ),
              ),
              ExpansionPanel(
                canTapOnHeader: true,
                isExpanded: _isExpandedList[1],
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const ListTile(
                    title: Text('Comment rechercher un article ?'),
                  );
                },
                body: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Utilisez la barre de recherche en haut pour trouver rapidement des articles pertinents.',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget footerSections() {
    return Column(
      children: [
        Column(
          children: [
            ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              leading: Container(),
              title: Text(
                'Comment puis-je mettre un article en vente ?',
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
                        '''Pour mettre un article en vente, rendez-vous sur 
                       votre tableau de bord et cliquez sur "Publier une annonce"
                       dans le menu de navigation. Remplissez le formulaire d'annonce 
                       avec les détails de votre article, y compris le titre, la description, 
                       le prix et les photos. Une fois que vous êtes satisfait, cliquez sur "Publier l'annonce" 
                       pour rendre votre article visible aux acheteurs potentiels.''',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          color: greyColo1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
