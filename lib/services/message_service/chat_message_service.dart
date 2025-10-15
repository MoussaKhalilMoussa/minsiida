import 'package:simple_nav_bar/view/profile/model/conversation.dart';
import 'package:simple_nav_bar/view/profile/model/message.dart';

abstract class ChatMessageService {

Future<List<Conversation?>> getMyConversations({required int userId});

  Future<Message?> sendMessage({
    required int senderId,
    required int receiverId,
    required String content,
  });
}
