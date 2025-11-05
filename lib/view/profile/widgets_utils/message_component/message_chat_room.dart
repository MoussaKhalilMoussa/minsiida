import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:simple_nav_bar/controllers/profile_controllers/messages_controller/messages_controller.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/profile/profile_controller.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/profile/model/conversation.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/message_component/own_message_card.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/message_component/reply_card.dart';

class MessageChatRoom extends StatelessWidget {
  MessageChatRoom({super.key, required this.conversation});

  final Conversation conversation;

  final messageController = Get.find<MessagesController>();
  final profilleController = Get.find<ProfileController>();

  final FocusNode inputFocus = FocusNode(); // persistent focus node

  @override
  Widget build(BuildContext context) {
    final bottomPadding = Platform.isIOS ? 0.0 : 0.0;
    final leftPadding = Platform.isIOS ? 0.0 : 0.0;
    final rightPadding = Platform.isIOS ? 0.0 : 0.0;

    inputFocus.addListener(() {
      if (inputFocus.hasFocus &&
          messageController.showEmojiPicker.value == true) {
        messageController.showEmojiPicker.value = false;
      }
    });

    return Obx(() {
      UserProfile user = conversation.partner;

      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: greyColo1.withValues(alpha: 1.3),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (messageController.showEmojiPicker.value) {
                messageController.showEmojiPicker.value = false;
              } else {
                messageController.disconnectSocket();
                Get.back();
              }
            },
          ),
          titleSpacing: 0,
          title: Row(
            children: [
              /* CircleAvatar(
                radius: 20,
                backgroundColor: blueColor,
                child: const Icon(Icons.person, color: Colors.white),
              ), */
              CircleAvatar(
                backgroundColor: blueColor,
                radius: 20,
                child: ClipOval(
                  child:
                      user.profilePicture != null &&
                              user.profilePicture!.isNotEmpty
                          ? Image.network(
                            user.profilePicture!,
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                            errorBuilder:
                                (context, error, stackTrace) => Image.asset(
                                  'assets/icons/profile.png',
                                  width: 20,
                                  height: 20,
                                  color: whiteColor,
                                ),
                          )
                          : Image.asset(
                            'assets/icons/profile.png',
                            width: 20,
                            height: 20,
                            color: whiteColor,
                          ),
                ),
              ),

              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name!,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "last seen today at ${extractTime(conversation.lastMessage.timestamp!)}",
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) return;
                if (messageController.showEmojiPicker.value) {
                  messageController.showEmojiPicker.value = false;
                  return;
                }
                Get.back();
              },
              child: Expanded(
                flex: 12,
                child:
                    messageController.messagesLoading.value
                        ? Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                        : ListView.builder(
                          itemCount: messageController.messages.length,
                          padding: EdgeInsets.only(top: 12),
                          itemBuilder: (context, index) {
                            final message =
                                messageController.messages.toList()[index];
                            final isOwn =
                                message.sender ==
                                profilleController.currentUserId.toString();
                            if (isOwn) {
                              return OwnMessageCard(
                                message: message.content!,
                                time: extractTime(message.timestamp!),
                                isSeen: message.read!,
                              );
                            } else {
                              return ReplyCard(
                                message: message.content!,
                                time: extractTime(message.timestamp!),
                              );
                            }
                          },
                        ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          bottom: Platform.isIOS ? true : false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              leftPadding,
              8.0,
              rightPadding,
              bottomPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputArea(
                  context,
                  onPressed: () async {
                    messageController.sendMessage(
                      messageController.sendMessageContentController.text,
                      user.id!,
                    );
                  },
                ),
                Offstage(
                  offstage: !messageController.showEmojiPicker.value,
                  child: SizedBox(
                    height: 256,
                    child: EmojiPicker(
                      textEditingController:
                          messageController.sendMessageContentController,
                      config: Config(
                        height: 256,
                        checkPlatformCompatibility: true,
                        emojiViewConfig: EmojiViewConfig(
                          emojiSizeMax:
                              28 *
                              (foundation.defaultTargetPlatform ==
                                      TargetPlatform.iOS
                                  ? 1.20
                                  : 1.0),
                        ),
                        viewOrderConfig: const ViewOrderConfig(
                          top: EmojiPickerItem.categoryBar,
                          middle: EmojiPickerItem.emojiView,
                          bottom: EmojiPickerItem.searchBar,
                        ),
                        categoryViewConfig: const CategoryViewConfig(),
                        searchViewConfig: SearchViewConfig(),
                        bottomActionBarConfig: const BottomActionBarConfig(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInputArea(
    BuildContext context, {
    required void Function()? onPressed,
  }) {
    return Row(
      children: [
        Expanded(
          child: Card(
            margin: const EdgeInsets.only(left: 4, right: 2, bottom: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 42,
                    right: 40,
                    top: 6,
                    bottom: 6,
                  ),
                  child: TextFormField(
                    controller: messageController.sendMessageContentController,
                    focusNode: inputFocus,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    minLines: 1,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: const InputDecoration(
                      hintText: "Écrire un message",
                      border: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 2,
                  child: IconButton(
                    icon: const Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.amberAccent,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      messageController.showEmojiPicker.value =
                          !messageController.showEmojiPicker.value;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, right: 2),
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 25,
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

/*

ListView.builder(
itemCount: messageController.messages.length,
padding: EdgeInsets.only(top: 12),
itemBuilder: (context, index) {
final message =
messageController.messages.toList()[index];
final isOwn =
message.sender ==
profilleController.currentUserId.toString();
if (isOwn) {
return OwnMessageCard(
message: message.content!,
time: extractTime(message.timestamp!),
isSeen: message.read!,
);
} else {
return ReplyCard(
message: message.content!,
time: extractTime(message.timestamp!),
);
}
},
),*/
