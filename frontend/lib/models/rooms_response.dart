// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);
import 'dart:convert';

import 'package:flutter_chat/models/room_model.dart';

RoomsResponse roomsResponseFromJson(String str) =>
    RoomsResponse.fromJson(json.decode(str));

String roomsResponseToJson(RoomsResponse data) => json.encode(data.toJson());

class RoomsResponse {
  RoomsResponse({
    required this.ok,
    required this.rooms,
  });

  bool ok;
  List<Room> rooms;

  factory RoomsResponse.fromJson(Map<String, dynamic> json) => RoomsResponse(
        ok: json["ok"],
        rooms: List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
      };
}
