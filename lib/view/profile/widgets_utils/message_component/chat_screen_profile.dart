import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/messages_controller/messages_controller.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/profile/profile_controller.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/message_component/message_chat_room.dart';

class ChatScreenProfile extends StatelessWidget {
  ChatScreenProfile({super.key});
  //final Conversation conversation;

  final messageController = Get.find<MessagesController>();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
   // UserProfile user = conversation.partner;
   // Message message = conversation.lastMessage;
    
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: blueColor,
            radius: 30,
            child: ClipOval(
              child:
                  messageController.user.value!.profilePicture != null && messageController.user.value!.profilePicture!.isNotEmpty
                      ? Image.network(
                        messageController.user.value!.profilePicture!,
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
            messageController.user.value!.name!,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: blackColor,
            ),
          ),
          subtitle: Text(
            '${messageController.message.value!.content}',
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
                extractTime(messageController.message.value!.timestamp!),
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              buildBadge("${messageController.newMessageCount.value}"), // test with any number
            ],
          ),

          onTap: () async {
            Get.to(() => MessageChatRoom(conversation: messageController.conversation.value!));
            await messageController.initChat(peer: messageController.user.value!.id!);
            await messageController.getConversationBtwTwoUser(messageController.user.value!.id!);
            //messageController.resetUnreadCount(conversation.partner.id!);

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
