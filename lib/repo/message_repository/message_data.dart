// ignore_for_file: non_constant_identifier_names

import 'package:bookstore_mobile/repo/message_repository/message_author.dart';

class MessageData {
  String id;
  int createAt;
  AuthorMessage author;
  String status;
  String text;
  String type;
  MessageData({
    required this.id,
    required this.createAt,
    required this.author,
    required this.status,
    required this.type,
    required this.text,
  });

  static List<MessageData> parseMessageDataList(map) {
    var list = map["data"] as List;
    return list.map((message) => MessageData.fromJson(message)).toList();
  }

  factory MessageData.fromJson(Map<String, dynamic> map) {
    return MessageData(
      author: AuthorMessage.fromJson(map['author']),
      createAt: int.parse(map["createAt"].toString()),
      id: map["id"],
      status: map["status"],
      text: map['text'],
      type: map["type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "type": type,
        "author": author,
        "createAt": createAt,
        "text": text
      };
}
