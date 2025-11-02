import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/messages_controller/messages_controller.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/profile/model/conversation.dart';
import 'package:simple_nav_bar/view/profile/model/message.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/message_component/message_chat_room.dart';

class ChatScreenProfile extends StatelessWidget {
  ChatScreenProfile({super.key, required this.conversation});
  final Conversation conversation;

  final messageController = Get.find<MessagesController>();

  @override
  Widget build(BuildContext context) {
    UserProfile user = conversation.partner;
    Message message = conversation.lastMessage;
    final count = messageController.unreadCounts[conversation.partner.id] ?? 0;
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: blueColor,
            radius: 30,
            child: ClipOval(
              child:
                  user.profilePicture != null && user.profilePicture!.isNotEmpty
                      ? Image.network(
                        user.profilePicture!,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                        errorBuilder:
                            (context, error, stackTrace) => Image.asset(
                              'assets/icons/profile.png',
                              width: 28,
                              height: 28,
                              color: whiteColor,
                            ),
                      )
                      : Image.asset(
                        'assets/icons/profile.png',
                        width: 28,
                        height: 28,
                        color: whiteColor,
                      ),
            ),
          ),
          title: Text(
            user.name!,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: blackColor,
            ),
          ),
          subtitle: Text(
            '${message.content}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(color: greyColor, fontSize: 14),
          ),
          // 👇 FIXED TRAILING SECTION
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                extractTime(message.timestamp!),
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              buildBadge("$count"), // test with any number
            ],
          ),

          onTap: () async {
            Get.to(() => MessageChatRoom(conversation: conversation));
            await messageController.initChat(peer: user.id!);
            await messageController.getConversationBtwTwoUser(user.id!);
            messageController.resetUnreadCount(conversation.partner.id!);

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
