import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class AuthADeuxFacteurNotContainer extends StatelessWidget {
  const AuthADeuxFacteurNotContainer({super.key});

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
                color: purple_600.withValues(alpha: .1),
                //borderRadius: BorderRadius.circular(8),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Ionicons.lock_closed_outline,
                size: 20,
                color: purple_600,
              ),
            ),
            title: Text(
              'Authentification à deux facteurs',
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

            //subtitle: const Text('Manage your notification settings'),
          ),
          const Divider(height: 1),
          ListTile(
            title: Text(
              'Ajoutez une couche de sécurité supplémentaire à votre compte en activant l\'authentification à deux facteurs.',
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: greyColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            horizontalTitleGap: 8,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: primaryColor.withValues(alpha: 0.1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Ionicons.alert_circle_outline,
                      size: 10,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          "L'authentification à deux facteurs est actuellement désactivée",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 10,
                            color: blackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Lorsque l'A2F est activée, vous devrez saisir un code provenant de votre téléphone en plus de votre mot de passe lors de la connexion.",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 10,
                            color: greyColor,
                            //fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ElevatedButton(
                          style: ButtonStyle(
                            visualDensity: VisualDensity.comfortable,
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8),
                              ),
                            ),
                            //fixedSize: WidgetStatePropertyAll(Size(130,30))  ,
                            backgroundColor: WidgetStatePropertyAll(
                              primaryColor.withValues(alpha: 0.1),
                            ),
                            shadowColor: WidgetStatePropertyAll(
                              Colors.transparent,
                            ),
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 18,
                              ),
                            ),
                            foregroundColor: WidgetStatePropertyAll(
                              primaryColor,
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Activer l'A2F",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
