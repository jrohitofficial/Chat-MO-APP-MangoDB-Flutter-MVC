import 'dart:convert';

import 'package:flutter_chat/global/environment.dart';
import 'package:flutter_chat/models/room_model.dart';
import 'package:flutter_chat/models/rooms_response.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RoomService with ChangeNotifier {
  //late User userFrom;

  Future createRoom(String name) async {
    //logeando = true;

    final request = {'groupname': name};

    final response = await http.post(Uri.parse('${Environment.apiUrl}/groups'),
        body: jsonEncode(request),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken() ?? 'Default Value',
        });
    //logeando = false;

    if (response.statusCode == 200) {
      return true;
    } else {
      return; // jsonDecode(response.body)['msg']
    }
  }

  Future<List<Room>> getRooms() async {
    try {
      final response = await http
          .get(Uri.parse('${Environment.socketUrl}/api/groups'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? 'Default Value',
      });

      final data = roomsResponseFromJson(response.body);

      return data.rooms;
    } catch (e) {
      return [];
    }
  }
}
