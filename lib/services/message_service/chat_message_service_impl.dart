import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_nav_bar/dio_networking/dio_api_client.dart';
import 'package:simple_nav_bar/services/message_service/chat_message_service.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/profile/model/conversation.dart';
import 'package:simple_nav_bar/view/profile/model/message.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class ChatMessageServiceImpl implements ChatMessageService {
  final DioApiClient _dio = GetIt.I<DioApiClient>();
  StompClient? stompClient;

  Function(Message)? onMessageReceived;
  @override
  Future<List<Conversation?>> getMyConversations({required int userId}) async {
    try {
      final response = await _dio.readDataWithoutAuth(
        "/api/messages/conversations/$userId",
      );

      if (response.data != null) {
        return Conversation.listFromJson(response.data);
      } else {
        return [];
      }
    } on DioException catch (e) {
      logger.severe("DioException in getMyConversations: $e");
      rethrow;
    } catch (e) {
      logger.severe(" Unexpected error in getMyConversations service : $e");
      rethrow;
    }
  }

  /* 
  void connect(int userId) {
    // ✅ Create and connect socket
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://app.minsiida.com:8080/ws',
        onConnect: (StompFrame frame) {
          logger.info("Connected to WebSocket as user $userId");

          stompClient!.subscribe(
            destination: '/topic/user/$userId',
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
  }
 */
  @override
  Future<Message?> sendMessage({
    required int senderId,
    required int receiverId,
    required String content,
  }) async {
    final message = {
      "sender": senderId,
      "receiver": receiverId,
      "content": content,
    };

    // Prefer WebSocket if connected
    if (stompClient != null && stompClient!.connected) {
      logger.info("Sending via WebSocket...");
      stompClient!.send(destination: "/app/chat", body: json.encode(message));
      return null; // Message will arrive through onMessageReceived
    }

    // Fallback to REST API
    try {
      logger.info("Sending via REST fallback...");
      final response = await _dio.createDtaWitoutAuth(
        "/api/messages/send",
        message,
      );
      if (response.data != null) {
        return Message.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      logger.severe("DioException in sendMessage: $e");
      rethrow;
    } catch (e) {
      logger.severe(" Unexpected error: $e");
      rethrow;
    }
  }

  /// ✅ Fetch conversation between two users
  @override
  ///
  Future<List<Message>> getConversationBtwTwoUser({
    required int userId1,
    required int userId2,
  }) async {
    try {
      final response = await _dio.readDataWithoutAuth(
        "/api/messages",
        queryParameters: {'user1': userId1, 'user2': userId2},
      );

      if (response.data != null) {
        final data = response.data as List;
        return data.map((e) => Message.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      logger.severe("❌ Error loading conversation: $e");
      rethrow;
    }
  }

  /// ✅ Disconnect cleanly
  void disconnect() {
    if (stompClient != null && stompClient!.connected) {
      stompClient!.deactivate();
      logger.info("👋 Disconnected from WebSocket");
    }
  }

}
