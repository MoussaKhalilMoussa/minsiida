import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/assistance_components_widgets/selectionButton.dart';

class SoumettreUnTicketDeSupport extends StatelessWidget {
  const SoumettreUnTicketDeSupport({super.key});

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
                color: amber.withValues(alpha: .1),
                //borderRadius: BorderRadius.circular(8),
                shape: BoxShape.circle,
              ),

              child: Icon(
                Ionicons.document_text_outline,
                size: 20,
                color: amber,
              ),
            ),
            title: Text(
              'Soumettre un ticket de support',
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.0,
                      vertical: 8,
                    ),
                    child: Text(
                      'Sujet',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: blackColor2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  TextFormField(
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: blackColor2,
                    ),
                    decoration: InputDecoration(
                      constraints: BoxConstraints(
                        maxHeight: 45.h,
                        maxWidth: double.maxFinite,
                      ),
                      hint: Text(
                        "Entrez le sujet de votre demande.",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: blackColor2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: greyColor.withValues(
                            alpha: 0.2,
                          ), // border color set to yellow
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: greyColor.withValues(
                            alpha: 0.2,
                          ), // border color set to yellow
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: greyColor.withValues(
                            alpha: 0.2,
                          ), // border color set to yellow
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.0,
                      vertical: 8,
                    ),
                    child: Text(
                      "Catégorie",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: blackColor2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Selectionbutton(),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.0,
                      vertical: 8,
                    ),
                    child: Text(
                      'Description',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: blackColor2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  TextFormField(
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: blackColor2,
                    ),
                    minLines: 5,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Décrivez votre problème en détail",
                      hintStyle: GoogleFonts.playfairDisplay(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: greyColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: greyColor.withValues(alpha: 0.2),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: greyColor.withValues(alpha: 0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: greyColor.withValues(alpha: 0.2),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        //SizedBox(height: 10.h),
      ),
    );
  }
}
