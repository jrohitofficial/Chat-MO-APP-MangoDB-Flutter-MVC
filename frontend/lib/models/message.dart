// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    required this.from,
    required this.to,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.groupChat,
    required this.name,
  });

  String from;
  String to;
  String message;
  DateTime createdAt;
  DateTime updatedAt;
  bool groupChat;
  String name;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["from"],
        to: json["to"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        groupChat: json["groupChat"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "groupChat": groupChat,
        "name": name,
      };
}
