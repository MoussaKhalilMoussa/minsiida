import 'package:simple_nav_bar/view/profile/model/message.dart';

abstract class MessageService {
  Future<Message?> sendMessage({
    required int senderId,
    required int receiverId,
    required String content,
  });
}
