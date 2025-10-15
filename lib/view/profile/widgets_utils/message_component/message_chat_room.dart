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
    inputFocus.addListener(() {
      if (inputFocus.hasFocus &&
          messageController.showEmojiPicker.value == true) {
        messageController.showEmojiPicker.value = false;
      }
    });

    return Obx(() {
      UserProfile user = conversation.partner;

      return Scaffold(
        backgroundColor: greyColo1.withValues(alpha: 1.3),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (messageController.showEmojiPicker.value) {
                messageController.showEmojiPicker.value = false;
              } else {
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
                    "last seen today at 12:05 AM",
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            if (messageController.showEmojiPicker.value) {
              messageController.showEmojiPicker.value = false;
              return;
            }
            Get.back();
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: messageController.messages.length,
                  itemBuilder: (context, index) {
                    final message =
                        messageController.messages.reversed.toList()[index];
                    final isOwn =
                        message.sender ==
                        profilleController.currentUserId.toString();
                    if (isOwn) {
                      return OwnMessageCard(
                        message: message.content!,
                        time: extractTime(message.timestamp!),
                      );
                    } else {
                      return ReplyCard(
                        message: message.content!,
                        time: extractTime(message.timestamp!),
                      );
                    }
                  },
                ), // chat messages area
              ),
              _buildInputArea(context),
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
      );
    });
  }

  Widget _buildInputArea(BuildContext context) {
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
              onPressed: () {},
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
