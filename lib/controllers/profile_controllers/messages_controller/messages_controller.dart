import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/profile/profile_controller.dart';
import 'package:simple_nav_bar/services/message_service/message_service_impl.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/profile/model/message.dart';
import 'package:flutter/foundation.dart' as foundation;

class MessagesController extends GetxController {
  final messageService = Get.put<MessageServiceImpl>(MessageServiceImpl());
  final profileController = Get.find<ProfileController>();
  TextEditingController sendMessageContentController = TextEditingController();
  RxBool sending = false.obs;
  RxString error = "".obs;
  RxBool showEmojiPicker = false.obs;
  RxBool showSearchBar = false.obs;

  var receievdMessage = Rxn<Message>();

  Future<void> sendMessage({required int receiverId}) async {
    try {
      sending.value = true;
      error.value = "";
      receievdMessage.value = Message();
      final response = await messageService.sendMessage(
        senderId: profileController.currentUserId,
        receiverId: receiverId,
        content: sendMessageContentController.text,
      );
      if (response != null) {
        receievdMessage.value = response;
        sending.value = false;
      } else {
        error.value = "errure du serveur";
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in sendMessage messageController: $e");
    }
  }


  @override
  void onClose() {
    sendMessageContentController.dispose();
    super.onClose();
  }
}
