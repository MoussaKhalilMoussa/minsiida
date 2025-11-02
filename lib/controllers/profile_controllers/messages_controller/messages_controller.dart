import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/profile/profile_controller.dart';
import 'package:simple_nav_bar/services/message_service/chat_message_service_impl.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/profile/model/conversation.dart';
import 'package:simple_nav_bar/view/profile/model/message.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class MessagesController extends GetxController {
  final messageService = Get.put<ChatMessageServiceImpl>(
    ChatMessageServiceImpl(),
  );
  final profileController = Get.find<ProfileController>();

  final TextEditingController sendMessageContentController =
      TextEditingController();

  StompClient? stompClient;
  Function(Message)? onMessageReceived;

  final RxBool sending = false.obs;
  final RxString error = "".obs;
  final RxBool showEmojiPicker = false.obs;
  final RxBool showSearchBar = false.obs;
  final RxBool conversationLoading = false.obs;
  final RxBool messagesLoading = false.obs;
  final RxBool isConnected = false.obs;

  final RxList<Message> messages = <Message>[].obs;
  final RxList<Conversation> conversations = <Conversation>[].obs;
  final RxInt newMessageCount = 0.obs;

  /// Maps userId → number of unread messages
  final RxMap<int, int> unreadCounts = <int, int>{}.obs;

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
      final nonNullConversations =
          response
              .whereType<Conversation>() // removes nulls safely
              .toList();

      conversations.assignAll(nonNullConversations);
    } catch (e, s) {
      logger.severe(
        "Unexpected error occurred in getMyConversations message controller : $e",
        s,
      );
      error.value = e.toString();
    } finally {
      conversationLoading.value = false;
    }
  }

  /// Initialize chat socket and listen to incoming messages
  Future<void> initChat({required int peer}) async {
    final currentUserId = profileController.currentUserId;
    final int peerId = peer;

    // ✅ Set up message handler first
    onMessageReceived = (msg) {
      //final currentUserId = profileController.currentUserId;
      final senderId = int.parse(msg.sender!);
      final receiverId = int.parse(msg.receiver!);
      // Add the message if it belongs to the currently open chat
      if ((senderId == peerId && receiverId == currentUserId) ||
          (senderId == currentUserId && receiverId == peerId)) {
        messages.add(msg);
      }

      // ✅ Update unread count if it's a new incoming message
      if (receiverId == currentUserId && senderId != peerId) {
        unreadCounts[senderId] = (unreadCounts[senderId] ?? 0) + 1;
        unreadCounts.refresh(); // important for Obx update
      }
    };

    // ✅ Create and connect socket
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://app.minsiida.com:8080/ws',
        onConnect: (StompFrame frame) {
          logger.info("Connected to WebSocket as user $currentUserId");

          stompClient!.subscribe(
            destination: '/topic/user/$currentUserId',
            callback: (frame) {
              if (frame.body != null) {
                final data = json.decode(frame.body!);
                final message = Message.fromJson(data);

                // ✅ Immediately trigger the handler
                onMessageReceived?.call(message);
              }
            },
          );
        },
        onWebSocketError: (error) => logger.severe("WebSocket error: $error"),
        onDisconnect: (frame) => logger.warning("⚠️ WebSocket disconnected"),
      ),
    );

    stompClient!.activate();

    // ✅ Load existing messages after socket is ready
    messages.clear();
    await getConversationBtwTwoUser(peerId);
  }

  Future<void> getConversationBtwTwoUser(int peerUserId) async {
    final currentUserId = profileController.currentUserId;
    try {
      messagesLoading.value = true;
      final msgs = await messageService.getConversationBtwTwoUser(
        userId1: currentUserId,
        userId2: peerUserId,
      );
      messages.assignAll(msgs as Iterable<Message>);
    } catch (e, s) {
      logger.warning("Failed to get conversation: $e", s);
      error.value = e.toString();
    } finally {
      messagesLoading.value = false;
    }
  }

  /// Send message and handle validation
  Future<void> sendMessage(String text, int receiverId) async {
    final content = text.trim();
    if (content.isEmpty) return;
    final currentUserId = profileController.currentUserId;

    final tempMsg = Message(
      sender: currentUserId.toString(),
      receiver: receiverId.toString(),
      content: content,
      timestamp: DateTime.now().toIso8601String(),
      read: false,
    );

    // ✅ Add message locally for instant feedback
    messages.add(tempMsg);
    try {
      sending.value = true;
      await messageService.sendMessage(
        senderId: currentUserId,
        receiverId: receiverId,
        content: content,
      );
      sendMessageContentController.clear();
      // Add message locally only if it was returned (e.g., REST fallback)
    } catch (e, s) {
      logger.warning("Failed to send message: $e", s);
      error.value = e.toString();
    } finally {
      sending.value = false;
    }
  }

  void resetUnreadCount(int peerId) {
    unreadCounts[peerId] = 0;
    unreadCounts.refresh();
  }

  int? calculateNonReadMessage(int receiverId) {
    int read = 0;
    for (var mes in messages) {
      if (mes.read == false && mes.receiver == receiverId.toString()) {
        read++;
      }
    }
    return read;
  }

  void disconnectSocket() {
    messageService.disconnect();
  }

  @override
  void onClose() {
    sendMessageContentController.dispose();
    messages.clear();
    conversations.clear();
    super.onClose();
  }
}
