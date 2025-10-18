import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/messages_controller/messages_controller.dart';
import 'package:simple_nav_bar/view/profile/model/conversation.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/message_component/chat_screen_profile.dart';

class MessagesPage extends StatelessWidget {
  MessagesPage({super.key});

  final messageController = Get.find<MessagesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Obx(() {
        return CustomScrollView(
          //physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              backgroundColor: whiteColor,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Ionicons.chevron_back_outline),
                onPressed: () => Navigator.of(context).pop(),
              ),
              centerTitle: true,
              title: Text(
                'Messages',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                ),
              ),
              floating: true,
              snap: true,
            ),
            const SliverToBoxAdapter(child: Divider(height: 1)),
            SliverList(
              delegate: SliverChildListDelegate([
                Center(
                  child: Container(
                    width: MediaQuery.sizeOf(Get.context!).width,
                    margin: EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: MediaQuery.sizeOf(Get.context!).width * 0.95,
                          child: TextField(
                            decoration: InputDecoration(
                              //focusColor: greyColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: greyColor,
                                  width: 1,
                                ),
                              ),
                              filled: true,
                              fillColor: whiteColor,
                              hintText: "Rechercher des messages...",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                messageController.conversationLoading.value
                    ? Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                        left: 2,
                        right: 2,
                        top: MediaQuery.sizeOf(context).height / 3,
                        bottom: 20,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      width: MediaQuery.sizeOf(Get.context!).width,
                      color: Colors.transparent,
                      child: Center(child: CircularProgressIndicator()),
                    )
                    : messageController.conversations.isEmpty
                    ? Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        left: 2,
                        right: 2,
                        top: MediaQuery.sizeOf(context).height / 3,
                        bottom: 20,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      width: MediaQuery.sizeOf(Get.context!).width,
                      color: Colors.transparent,
                      child: Text("start conversation with a friend."),
                    )
                    : Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                        left: 2,
                        right: 2,
                        top: 0,
                        bottom: 20,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      width: MediaQuery.sizeOf(Get.context!).width,
                      color: Colors.transparent,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 0,
                        ),
                        itemBuilder: (context, index) {
                          Conversation conversation =
                              messageController.conversations[index];
                          return ChatScreenProfile(conversation: conversation);
                        },
                        itemCount: messageController.conversations.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ),
              ]),
            ),
          ],
        );
      }),
    );
  }
}
