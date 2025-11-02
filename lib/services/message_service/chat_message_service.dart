import 'package:simple_nav_bar/view/profile/model/conversation.dart';
import 'package:simple_nav_bar/view/profile/model/message.dart';

abstract class ChatMessageService {

Future<List<Conversation?>> getMyConversations({required int userId});

Future<List<Message?>> getConversationBtwTwoUser({required int userId1,required int userId2});


Future<Message?> sendMessage({
    required int senderId,
    required int receiverId,
    required String content,
  });
}
