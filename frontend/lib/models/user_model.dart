// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.online,
    required this.name,
    required this.email,
    required this.uid,
    required this.time,
  });

  bool online;
  String name;
  String email;
  String uid;
  String time;

  factory User.fromJson(Map<String, dynamic> json) => User(
        online: json["online"],
        name: json["name"],
        email: json["email"],
        uid: json["uid"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "online": online,
        "name": name,
        "email": email,
        "uid": uid,
        "time": time,
      };
}
