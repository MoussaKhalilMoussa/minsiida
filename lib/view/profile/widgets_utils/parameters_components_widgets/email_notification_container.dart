import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class EmailNotificationContainer extends StatelessWidget {
  const EmailNotificationContainer({super.key});

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
                color: primaryColor.withValues(alpha: .1),
                //borderRadius: BorderRadius.circular(8),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Ionicons.notifications_outline,
                size: 20,
                color: primaryColor,
              ),
            ),
            title: Text(
              'Notifications par email',
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
              'Nouveaux messages',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: greyColor,
              ),
            ),
            value: false,
            subtitle: Text(
              'Soyez notifié lorsque vous recevez un nouveau message',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w400,
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
              'Nouvelles offres',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: greyColor,
              ),
            ),
            value: true,
            subtitle: Text(
              'Soyez notifié lorsque vous recevez une nouvelle offre',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w400,
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
              'Mises à jour des commandes',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: greyColor,
              ),
            ),
            value: true,
            subtitle: Text(
              'Soyez notifié des changements de statut des commandes',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w400,
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
              'Emails marketing',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: greyColor,
              ),
            ),
            value: false,
            subtitle: Text(
              'Recevez des offres spéciales et des promotions',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w400,
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
