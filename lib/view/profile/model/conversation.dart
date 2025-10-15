
import 'package:simple_nav_bar/view/profile/model/message.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';

class Conversation {
  final UserProfile partner;
  final Message lastMessage;

  Conversation({required this.partner, required this.lastMessage});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      partner: UserProfile.fromJson(json['partner']),
      lastMessage: Message.fromJson(json['lastMessage']),
    );
  }

  Map<String, dynamic> toJson() => {
    'partner': partner.toJson(),
    'lastMessage': lastMessage.toJson(),
  };

  static List<Conversation> listFromJson(List<dynamic> jsonList) {
   // final data = jsonList.map((json) => json.decode(json));
    return jsonList.map((e) => Conversation.fromJson(e)).toList();
  }
}
