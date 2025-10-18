import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class ParaDesConfiNotContainer extends StatelessWidget {
  const ParaDesConfiNotContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            leading: Container(
              margin: const EdgeInsets.only(right: 0, left: 0),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: darkGreen.withValues(alpha: 0.1),
                //borderRadius: BorderRadius.circular(8),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Ionicons.eye_outline,
                size: 20,
                color: darkGreen,
              ),
            ),
            title: Text(
              'Paramètres de confidentialité',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: blackColor2,
              ),
            ),
            horizontalTitleGap: 8,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),

            //subtitle: const Text('Manage your notification settings'),
          ),
          const Divider(height: 1),
          SwitchListTile(
            activeTrackColor: primaryColor,
            inactiveTrackColor: greyColo1.withValues(alpha: 0.3),
            inactiveThumbColor: whiteColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            trackOutlineColor: WidgetStatePropertyAll(
              greyColo1.withValues(alpha: 0.3),
            ),
            title: Text(
              'Afficher mon profil aux utilisateurs inscrits',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: greyColor,
              ),
            ),
            value: true,
            subtitle: Text(
              'Vos informations de profil seront visibles par d\'autres utilisateurs',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                fontSize: 10,
                color: greyColor.withValues(alpha: 0.7),
              ),
            ),
            onChanged: (bool value) {
              // Handle push notification toggle
            },
          ),
          const Divider(height: 1),
          SwitchListTile(
            activeTrackColor: primaryColor,
            inactiveTrackColor: greyColo1.withValues(alpha: 0.3),
            inactiveThumbColor: whiteColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            trackOutlineColor: WidgetStatePropertyAll(
              greyColo1.withValues(alpha: 0.3),
            ),
            title: Text(
              'Afficher mon statut en ligne',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: greyColor,
              ),
            ),
            value: true,
            subtitle: Text(
              'Les autres utilisateurs verront quand vous êtes en ligne',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                fontSize: 10,
                color: greyColor.withValues(alpha: 0.7),
              ),
            ),
            onChanged: (bool value) {
              // Handle push notification toggle
            },
          ),
          const Divider(height: 1),
          SwitchListTile(
            activeTrackColor: primaryColor,
            inactiveTrackColor: greyColo1.withValues(alpha: 0.3),
            inactiveThumbColor: whiteColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            trackOutlineColor: WidgetStatePropertyAll(
              greyColo1.withValues(alpha: 0.3),
            ),
            title: Text(
              'Partager mon activité',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: greyColor,
              ),
            ),
            value: false,
            subtitle: Text(
              'Permettre aux autres de voir vos annonces et achats récents',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                fontSize: 10,
                color: greyColor.withValues(alpha: 0.7),
              ),
            ),
            onChanged: (bool value) {
              // Handle push notification toggle
            },
          ),
        ],
      ),
    );
  }
}
