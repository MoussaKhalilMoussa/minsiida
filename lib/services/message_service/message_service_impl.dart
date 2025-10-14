import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_nav_bar/dio_networking/dio_api_client.dart';
import 'package:simple_nav_bar/services/message_service/message_service.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/profile/model/message.dart';

class MessageServiceImpl implements MessageService {
  final DioApiClient _dio = GetIt.I<DioApiClient>();

  @override
  Future<Message?> sendMessage({
    required int senderId,
    required int receiverId,
    required String content,
  }) async {
    try {
      final response = await _dio.createDtaWitoutAuth("/api/messages/send", {
        "sender": senderId,
        "receiver": receiverId,
        "content": content,
      });

      if (response.data != null) {
        return Message.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        logger.severe("❌ Error in sending message service: $e");
      }
      throw Exception(
        "Failed to send a message by sender and receiver ids due to DioException service",
      );
    } catch (e) {
      logger.severe("❌ Unexpected error in sendMessage service: $e");
      throw Exception(
        "Failed to send message by sender and receiver ids , service",
      );
    }
  }
}
