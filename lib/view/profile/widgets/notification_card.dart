import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

Widget buildNotificationCard({
  required String title,
  required String description,
  required String time,
  required bool isRead,
  required void Function()? onTap,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: isRead ? Colors.white : primaryColor,
    margin: const EdgeInsets.symmetric(vertical: 0),
    child: Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: primaryColor.withValues(alpha: 0.1),
            child: Icon(Ionicons.chatbubble_ellipses_outline, color: primaryColor, size: 24),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        left: MediaQuery.of(Get.context!).size.width * 0.25,
                      ),
                      child: Text(
                        time,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),

                    Spacer(),
                    if (!isRead)
                      Container(
                        margin: EdgeInsets.only(right: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                //SizedBox(width: 1),
                SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Chip(
                      padding: EdgeInsets.all(2),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      label: Text(
                        'Voir',
                        style: GoogleFonts.playfairDisplay(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: primaryColor.withValues(alpha: 0.05),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: onTap,
                      child: Chip(
                        padding: EdgeInsets.all(2),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        label: Text(
                          'Marque comme lu',
                          style: GoogleFonts.playfairDisplay(
                            color: greyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        backgroundColor: greyColo1.withValues(alpha: 0.05),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
