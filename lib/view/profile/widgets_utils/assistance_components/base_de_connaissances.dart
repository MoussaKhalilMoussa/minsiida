import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class Item {
  Item({
    required this.icon,
    required this.header,
    required this.body,
    required this.isExpanded,
  });
  String header;
  String body;
  Widget? icon;
  bool isExpanded;
}

class BaseDeConnaissances extends StatefulWidget {
  const BaseDeConnaissances({super.key});

  @override
  State<BaseDeConnaissances> createState() => _BaseDeConnaissancesState();
}

class _BaseDeConnaissancesState extends State<BaseDeConnaissances> {
  // Track expansion state for each panel

  final List<Item> _data = [
    Item(
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: greyColor.withValues(alpha: .1),
          shape: BoxShape.circle,
        ),
        child: Icon(Ionicons.bag_outline, size: 20, color: greyColor),
      ),
      header: "Comment puis-je mettre un article en vente ?",
      body:
          "Pour mettre un article en vente, rendez-vous sur votre tableau de bord et cliquez sur \"Publier une annonce\" dans le menu de navigation. Remplissez le formulaire d'annonce avec les détails de votre article, y compris le titre, la description,le prix et les photos. Une fois que vous êtes satisfait, cliquez sur \"Publier l'annonce\" pour rendre votre article visible aux acheteurs potentiels.",
      isExpanded: false,
    ),
    Item(
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: greyColor.withValues(alpha: .1),
          shape: BoxShape.circle,
        ),
        child: Icon(Ionicons.bag_outline, size: 20, color: greyColor),
      ),
      header: "Comment effectuer un achat ?",
      body:
          "Parcourez les annonces et lorsque vous trouvez un article que vous souhaitez acheter, cliquez sur l'annonce pour voir les détails. Vous pouvez soit acheter au prix indiqué en cliquant sur \"Acheter maintenant\", soit faire une offre en cliquant sur \"Faire une offre\". Suivez le processus de paiement pour finaliser votre achat.",
      isExpanded: false,
    ),
    Item(
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: greyColor.withValues(alpha: .1),
          shape: BoxShape.circle,
        ),
        child: Icon(Ionicons.card_outline, size: 20, color: greyColor),
      ),
      header: "Quels modes de paiement sont acceptés ?",
      body:
          "Nous acceptons divers modes de paiement, notamment les cartes de crédit/débit (Visa, Mastercard, American Express), PayPal et les virements bancaires. Tous les paiements sont traités en toute sécurité via notre plateforme pour protéger à la fois les acheteurs et les vendeurs.",
      isExpanded: false,
    ),
    Item(
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: greyColor.withValues(alpha: .1),
          shape: BoxShape.circle,
        ),
        child: Icon(Ionicons.cube_outline, size: 20, color: greyColor),
      ),
      header: "Comment fonctionne l'expédition ?",
      body:
          "Les vendeurs sont responsables de l'expédition des articles aux acheteurs. Lors de la création d'une annonce, les vendeurs peuvent spécifier les options et les coûts d'expédition. Une fois l'achat effectué, le vendeur recevra les informations d'expédition de l'acheteur et devra expédier l'article rapidement. Les informations de suivi doivent être fournies à l'acheteur dès qu'elles sont disponibles.",
      isExpanded: false,
    ),
    Item(
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: greyColor.withValues(alpha: .1),
          shape: BoxShape.circle,
        ),
        child: Icon(Ionicons.alert_circle_outline, size: 20, color: greyColor),
      ),
      header: "Que faire si je reçois un article endommagé ?",
      body:
          "Si vous recevez un article endommagé ou non conforme à la description, contactez immédiatement le vendeur via notre système de messagerie. Si vous ne parvenez pas à résoudre le problème directement avec le vendeur, vous pouvez ouvrir un litige dans la section \"Mes commandes\" de votre tableau de bord. Notre équipe d'assistance vous aidera à trouver une solution équitable.",
      isExpanded: false,
    ),
  ];

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
          ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: EdgeInsets.only(bottom: 0),
            animationDuration: const Duration(milliseconds: 500),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _data[index].isExpanded = isExpanded;
              });
            },
            children:
                _data.map<ExpansionPanel>((Item item) {
                  return ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: whiteColor,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        contentPadding: EdgeInsets.only(
                          bottom: 0,
                          left: 16,
                          right: 8,
                          top: 0,
                        ),
                        leading: item.icon,
                        title: Text(
                          item.header,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 12,
                            color: blackColor2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    body: ListTile(
                      subtitle: Text(
                        item.body,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 56,
                        right: 30,
                        top: 0,
                      ),
                    ),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
          ),
          ListTile(
            title: Center(
              child: Text(
                "Voir tous les articles",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          //SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
