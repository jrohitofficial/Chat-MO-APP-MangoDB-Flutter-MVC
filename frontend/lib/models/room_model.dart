// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Room roomFromJson(String str) => Room.fromJson(json.decode(str));

String roomToJson(Room data) => json.encode(data.toJson());

class Room {
  Room({
    required this.groupname,
    required this.uid,
  });

  String groupname;
  String uid;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        groupname: json["groupname"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "groupname": groupname,
        "uid": uid,
      };
}
