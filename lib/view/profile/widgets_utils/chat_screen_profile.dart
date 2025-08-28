import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/view/profile/pages/message_chat_room.dart';

class ChatScreenProfile extends StatelessWidget {
  const ChatScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteColor,
      margin: const EdgeInsets.symmetric(vertical: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(
            'assets/images/profile_image_joya_ahsan.jpg',
          ),
        ),
        title: Text(
          'Utilisateur',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: blackColor,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dernier message de l\'utilisateur',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.playfairDisplay(
                color: greyColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('12:34 PM'),
            CircleAvatar(radius: 4, backgroundColor: blueColor),
          ],
        ),
        onTap: () {
          // Action lors du tap sur un message
          Get.to(() => const MessageChatRoom());
        },
      ),
    );
  }
}
