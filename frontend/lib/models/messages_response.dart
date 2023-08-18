// To parse this JSON data, do
//
//     final messagesResponse = messagesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_chat/models/message.dart';

MessagesResponse messagesResponseFromJson(String str) =>
    MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) =>
    json.encode(data.toJson());

class MessagesResponse {
  MessagesResponse({
    required this.ok,
    required this.msj,
  });

  bool ok;
  List<Message> msj;

  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      MessagesResponse(
        ok: json["ok"],
        msj: List<Message>.from(json["msj"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msj": List<dynamic>.from(msj.map((x) => x.toJson())),
      };
}
