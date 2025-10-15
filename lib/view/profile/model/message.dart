class Message {
  int? id;
  String? sender;
  String? receiver;
  String? content;
  String? timestamp;
  bool? read;

  Message(
      {this.id,
      required this.sender,
      required this.receiver,
      required this.content,
      this.timestamp,
      this.read});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = json['sender'];
    receiver = json['receiver'];
    content = json['content'];
    timestamp = json['timestamp'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender'] = sender;
    data['receiver'] = receiver;
    data['content'] = content;
    data['timestamp'] = timestamp;
    data['read'] = read;
    return data;
  }
}
