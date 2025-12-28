import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/profile/profile_controller.dart';
import 'package:simple_nav_bar/services/message_service/chat_message_service_impl.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/profile/model/conversation.dart';
import 'package:simple_nav_bar/view/profile/model/message.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';
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

  final ScrollController scrollController = ScrollController();

  final RxBool sending = false.obs;
  final RxString error = "".obs;
  final RxBool showEmojiPicker = false.obs;
  final RxBool showSearchBar = false.obs;
  final RxBool conversationLoading = false.obs;
  final RxBool messagesLoading = false.obs;
  final RxBool isConnected = false.obs;

  final RxList<Message> messages = <Message>[].obs;
  final RxList<Conversation> conversations = <Conversation>[].obs;
  final Rxn<Conversation> conversation = Rxn<Conversation>();
  final Rxn<UserProfile> user = Rxn<UserProfile>();
  final Rxn<Message> message = Rxn<Message>();
  //final RxInt currentChatPeerId = RxInt(-1);

  final RxInt newMessageCount = 0.obs;

  /// Maps userId → number of unread messages
  final RxMap<int, int> unreadCounts = <int, int>{}.obs;
  bool _socketInitialized = false;
  final RxBool hasUnreadBelow = false.obs;
  late int? _currentPeerId;
  bool _initialScrollDone = false;

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

  /* Future<void> initChat({required int peer}) async {
    if (_socketInitialized) return;
    _socketInitialized = true;
    //final int peerId = peer;
    final currentUserId = profileController.currentUserId;

    // ✅ Set up message handler first
    onMessageReceived = (msg) {
      final senderId = int.parse(msg.sender!);
      final receiverId = int.parse(msg.receiver!);

      if (_exists(msg)) return;

      // Add the message if it belongs to the currently open chat
      // Add to chat UI if relevant
      if (_isCurrentChat(senderId, receiverId)) {
        messages.add(msg);

        if (_isUserAtBottom) {
          Future.delayed(const Duration(milliseconds: 50), () {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
            );
          });
        }
      }

      // Unread logic (GLOBAL)
      if (receiverId == currentUserId) {
        if (_isChatOpenWith(senderId)) {
          _markAsRead(msg);
        } else {
          _incrementUnread(senderId);
        }
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
    await getConversationBtwTwoUser(peer);
  }

 */

  Future<void> initChat({required int peer}) async {
    _currentPeerId = peer;
    _initialScrollDone = false;
    hasUnreadBelow.value = false;

    if (_socketInitialized) return;
    _socketInitialized = true;

    final currentUserId = profileController.currentUserId;

    onMessageReceived = (msg) {
      _handleIncomingMessage(msg);
    };

    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://app.minsiida.com:8080/ws',
        onConnect: (_) {
          stompClient!.subscribe(
            destination: '/topic/user/$currentUserId',
            callback: (frame) {
              if (frame.body == null) return;
              final data = json.decode(frame.body!);
              final message = Message.fromJson(data);
              onMessageReceived?.call(message);
            },
          );
        },
      ),
    );

    stompClient!.activate();

    messages.clear();
    await getConversationBtwTwoUser(peer);
  }

  void _handleIncomingMessage(Message msg) {
    final currentUserId = profileController.currentUserId;
    final senderId = int.parse(msg.sender!);
    final receiverId = int.parse(msg.receiver!);

    // Deduplication (IMPORTANT)
    if (messages.any((m) => m.id == msg.id)) return;

    final isCurrentChat =
        _currentPeerId != null &&
        ((senderId == _currentPeerId && receiverId == currentUserId) ||
            (senderId == currentUserId && receiverId == _currentPeerId));

    if (isCurrentChat) {
      messages.add(msg);

      if (_isUserAtBottom) {
        _scrollToBottom();
      } else {
        hasUnreadBelow.value = true;
      }
    }

    // Unread count for other chats
    if (receiverId == currentUserId && senderId != _currentPeerId) {
      unreadCounts[senderId] = (unreadCounts[senderId] ?? 0) + 1;
      unreadCounts.refresh();
    }
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
      //Scroll to bottom AFTER list is ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients && !_initialScrollDone) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
          _initialScrollDone = true;
        }
      });
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
    if (_isUserAtBottom) {
      Future.delayed(const Duration(milliseconds: 50), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      });
    }
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

  void _markAsRead(Message msg) {
    msg.read = true;
    //TODO:
    //messageService.markAsRead(msg.id!);
  }

  bool get _isUserAtBottom {
    if (!scrollController.hasClients) return true;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    return (maxScroll - currentScroll) < 80; // threshold
  }

  void _scrollToBottom() {
    if (!scrollController.hasClients) return;

    Future.delayed(const Duration(milliseconds: 50), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
      hasUnreadBelow.value = false;
    });
  }

  void scrollToBottomFromUI() {
    _scrollToBottom();
  }

  void disconnectSocket() {
    stompClient?.deactivate();
    stompClient = null;
    _socketInitialized = false;
  }

  @override
  void onClose() {
    disconnectSocket();
    sendMessageContentController.dispose();
    messages.clear();
    conversations.clear();
    super.onClose();
  }
}
