import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/profile/profile_controller.dart';
import 'package:simple_nav_bar/services/message_service/chat_message_service_impl.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/profile/model/conversation.dart';
import 'package:simple_nav_bar/view/profile/model/message.dart';

class MessagesController extends GetxController {
  final messageService = Get.put<ChatMessageServiceImpl>(
    ChatMessageServiceImpl(),
  );
  final profileController = Get.find<ProfileController>();

  final TextEditingController sendMessageContentController = TextEditingController();
  final RxBool sending = false.obs;
  final RxString error = "".obs;
  final RxBool showEmojiPicker = false.obs;
  final RxBool showSearchBar = false.obs;
  final RxBool conversationLoading = false.obs;
  final RxBool isConnected = false.obs;

  final RxList<Message> messages = <Message>[].obs;
  final RxList<Conversation> conversations = <Conversation>[].obs;

  //late final int peerId;

  /// Fetch all conversations for current user
  Future<void> getMyConversations() async {
    try {
      conversationLoading.value = true;
      conversations.clear();

      final response = await messageService.getMyConversations(
        userId: profileController.currentUserId,
      );

      // Ensure null safety and proper mapping
      final nonNullConversations = response
          .whereType<Conversation>() // removes nulls safely
          .toList();

      conversations.assignAll(nonNullConversations);
    } catch (e, s) {
      logger.severe("Unexpected error occurred in getMyConversations message controller : $e", s);
      error.value = e.toString();
    } finally {
      conversationLoading.value = false;
    }
  }

  /// Initialize chat socket and listen to incoming messages
  void initChat({required int peer}) {
    final currentUserId = profileController.currentUserId;
     final int peerId = peer;

    messageService.connect(currentUserId);

    // Clean previous messages before new chat
    messages.clear();

    // Listen to incoming messages
    messageService.onMessageReceived = (msg) {
      if ((msg.sender == peerId.toString() && msg.receiver == currentUserId.toString()) ||
          (msg.sender == currentUserId.toString() && msg.receiver == peerId.toString())) {
        messages.add(msg);
      }
    };
  }

  /// Send message and handle validation
  Future<void> sendMessage(String text, int receiverId) async {
    final content = text.trim();
    if (content.isEmpty) return;
    final currentUserId = profileController.currentUserId;
    try {
      sending.value = true;
      await messageService.sendMessage(
        senderId: currentUserId,
        receiverId: receiverId,
        content: content,
      );
      sendMessageContentController.clear();
    } catch (e, s) {
      logger.warning("Failed to send message: $e", s);
      error.value = e.toString();
    } finally {
      sending.value = false;
    }
  }

  @override
  void onClose() {
    sendMessageContentController.dispose();
    messages.clear();
    conversations.clear();
    super.onClose();
  }
}
