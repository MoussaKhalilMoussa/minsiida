import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:simple_nav_bar/controllers/profile_controllers/messages_controller/messages_controller.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/message_component/own_message_card.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/message_component/reply_card.dart';

class MessageChatRoom extends StatelessWidget {
  MessageChatRoom({super.key});

  final messaController = Get.put(MessagesController());
  final FocusNode inputFocus = FocusNode(); // persistent focus node

  @override
  Widget build(BuildContext context) {
    inputFocus.addListener(() {
      if (inputFocus.hasFocus &&
          messaController.showEmojiPicker.value == true) {
        messaController.showEmojiPicker.value = false;
      }
    });

    return Obx(() {
      return Scaffold(
        backgroundColor: greyColo1.withValues(alpha: 1.3),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (messaController.showEmojiPicker.value) {
                messaController.showEmojiPicker.value = false;
              } else {
                Get.back();
              }
            },
          ),
          titleSpacing: 0,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: blueColor,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
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
            if (messaController.showEmojiPicker.value) {
              messaController.showEmojiPicker.value = false;
              return;
            }
            Get.back();
          },
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    OwnMessageCard(message: ".",time: "12:56",),
                    ReplyCard(message: ". ",time: "08:39"),
                    OwnMessageCard(message: "Proper vertical alignment between text and timestamp.",time: "12:56",),
                    ReplyCard(message: "Proper vertical alignment between text ",time: "08:39"),
                    OwnMessageCard(message: "Pimestamp.",time: "12:56",),
                    ReplyCard(message: "Proper vertical alignment between ",time: "08:39"),
                    OwnMessageCard(message: "Proper vertical alignment between text and timestamp.",time: "12:56",),
                    ReplyCard(message: "Proper vertical alignment  text and timestamp.",time: "08:39"),
                    OwnMessageCard(message: "Proper vertical alignment between text and timestamp.",time: "12:56",),
                    ReplyCard(message: "Proper vertical alignment between text and ",time: "08:39"),
                    OwnMessageCard(message: "Proper timestamp.",time: "12:56",),
                    ReplyCard(message: "Proper vertical alignment between text and timestamp.",time: "08:39"),
                  ],
                ), // chat messages area
              ),
              _buildInputArea(context),
              Offstage(
                offstage: !messaController.showEmojiPicker.value,
                child: SizedBox(
                  height: 256,
                  child: EmojiPicker(
                    textEditingController:
                        messaController.sendMessageContentController,
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
                    controller: messaController.sendMessageContentController,
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
                      messaController.showEmojiPicker.value =
                          !messaController.showEmojiPicker.value;
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
