import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class ProfleSummary extends StatelessWidget {
  const ProfleSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: BoxBorder.all(color: greyColo1.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.teal,
                child: Text(
                  "M",
                  style: GoogleFonts.playfairDisplay(
                    color: whiteColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Manir MHT",
                    style: GoogleFonts.playfairDisplay(
                      color: blackColor2,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "Member depuis juillet 2019",
                    style: GoogleFonts.playfairDisplay(
                      color: greyColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                  Text("⭐ 5 (1)"),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          _localReusableWidget(
            icon: LucideIcons.clock3,
            text: "Derniere activite it y a 18 heures",
          ),
          _localReusableWidget(
            icon: LucideIcons.messageCircle,
            text: "Reponse en moyenne en 1 h",
          ),
          _localReusableWidget(
            icon: LucideIcons.clock3,
            text: "Derniere activite it y a 18 heures",
          ),
        ],
      ),
    );
  }

  Widget _localReusableWidget({required IconData? icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon, color: greyColor),
          SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.playfairDisplay(
              color: greyColor,
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
