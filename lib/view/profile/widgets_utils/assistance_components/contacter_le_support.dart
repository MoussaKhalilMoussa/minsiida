import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class ContacterLeSupport extends StatelessWidget {
  const ContacterLeSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            tileColor: darkGreen.withValues(alpha: 0.1),
            leading: Container(
              margin: const EdgeInsets.only(right: 0, left: 0),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: darkGreen.withValues(alpha: .1),
                //borderRadius: BorderRadius.circular(8),
                shape: BoxShape.circle,
              ),

              child: Icon(Ionicons.mail_outline, size: 20, color: darkGreen),
            ),
            title: Text(
              'Contacter le support',
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
          //const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Besoin d\'aide supplémentaire ? Notre équipe de support est là pour vous.',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  style: ButtonStyle(
                    visualDensity: VisualDensity.comfortable,
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                    ),
                    fixedSize: WidgetStatePropertyAll(
                      Size(double.maxFinite, 30.h),
                    ),
                    //fixedSize:   ,
                    backgroundColor: WidgetStatePropertyAll(darkGreen),
                    shadowColor: WidgetStatePropertyAll(Colors.transparent),
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    ),
                    foregroundColor: WidgetStatePropertyAll(whiteColor),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Nous contacter",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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
