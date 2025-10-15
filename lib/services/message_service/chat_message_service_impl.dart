import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_nav_bar/constants/strings.dart';
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

  void connect(int userId) {
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: "$baseUrl/ws",
        onConnect: (StompFrame frame) {
          logger.info("Connected to Websocket");
          // subscribe to personal topic
          stompClient!.subscribe(
            destination: '/topic/user/$userId',
            callback: (frame) {
              if (frame.body != null) {
                final data = json.decode(frame.body!);
                final message = Message.fromJson(data);
                onMessageReceived?.call(message);
              }
            },
          );
        },
        onWebSocketError: (error) => logger.severe("Websocket error: $error"),
      ),
    );
    stompClient!.activate();
  }

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
}
