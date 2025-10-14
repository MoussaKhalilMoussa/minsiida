import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/message_component/message_chat_room.dart';

class ChatScreenProfile extends StatelessWidget {
  const ChatScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          
          leading: CircleAvatar(
            backgroundColor: blueColor,
            radius: 30,
            child: Image(
              image: const AssetImage('assets/icons/profile.png'),
              width: 24,
              height: 24,
              color: whiteColor,
            ),
          ),
          title: Text(
            'Utilisateur',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: blackColor,
            ),
          ),
          subtitle: Text(
            'Dernier message de l\'utilisateur',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(color: greyColor, fontSize: 14),
          ),
          // 👇 FIXED TRAILING SECTION
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //mainAxisSize: MainAxisSize.min,
            children: [
              Text('12:34 PM', style: GoogleFonts.poppins(fontSize: 12)),
              buildBadge("10"), // test with any number
            ],
          ),

          onTap: () {
            Get.to(() => MessageChatRoom());
          },
        ),

        Padding(
          padding: const EdgeInsets.only(right: 20, left: 80),
          child: Divider(thickness: 0),
        ),
      ],
    );
  }
}

Widget buildBadge(String text) {
  return IntrinsicWidth(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.circular(12),
      ),
      //alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 10,
          color: whiteColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

