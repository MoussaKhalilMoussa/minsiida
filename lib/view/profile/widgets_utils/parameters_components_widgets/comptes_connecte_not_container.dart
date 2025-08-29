import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class ComptesConnecteNotContainer extends StatelessWidget {
  const ComptesConnecteNotContainer({super.key});

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

              child: Icon(Ionicons.link_outline, size: 20, color: amber),
            ),
            title: Text(
              'Comptes connectés',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Connectez vos comptes pour simplifier votre expérience.',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 12.h),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                  tileColor: greyColo1.withValues(alpha: 0.15),
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo,
                    child: Icon(Ionicons.logo_facebook, color: whiteColor),
                  ),
                  title: Text("Facebook"),
                  subtitle: Text("Non connecté"),

                  trailing: ElevatedButton(
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
                      shadowColor: WidgetStatePropertyAll(Colors.transparent),
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      ),
                      foregroundColor: WidgetStatePropertyAll(primaryColor),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Connecter",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12.h),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                  tileColor: greyColo1.withValues(alpha: 0.15),
                  leading: CircleAvatar(
                    backgroundColor: greyColor,
                    child: Icon(LucideIcons.x, color: whiteColor),
                  ),
                  title: Text("X"),
                  subtitle: Text("Non connecté"),

                  trailing: ElevatedButton(
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
                      shadowColor: WidgetStatePropertyAll(Colors.transparent),
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      ),
                      foregroundColor: WidgetStatePropertyAll(primaryColor),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Connecter",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12.h),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                  tileColor: greyColo1.withValues(alpha: 0.15),
                  leading: CircleAvatar(
                    backgroundColor: whiteColor,
                    child: Icon(Ionicons.logo_google, color: primaryColor),
                  ),
                  title: Text("Google"),
                  subtitle: Text(
                    "Connecté",
                    style: GoogleFonts.playfairDisplay(
                      color: darkGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  trailing: ElevatedButton(
                    style: ButtonStyle(
                      visualDensity: VisualDensity.comfortable,
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                      ),
                      //fixedSize: WidgetStatePropertyAll(Size(130,30))  ,
                      backgroundColor: WidgetStatePropertyAll(
                        redColor.withValues(alpha: 0.1),
                      ),
                      shadowColor: WidgetStatePropertyAll(Colors.transparent),
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      ),
                      foregroundColor: WidgetStatePropertyAll(redColor),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Déconnecter",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        //SizedBox(height: 10.h),
      ),
    );
  }
}
