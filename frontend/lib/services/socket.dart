import 'package:flutter_chat/global/environment.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Conecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Conecting;
  //late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  late IO.Socket socket;

  void connect(String room) async {
    //obtengo el token del storage
    final token = await AuthService.getToken();

    if (kIsWeb) {
      print('Conectant al socket... token = ${token}');
      print('Conectant al room... token = ${room}');

      socket = IO.io(Environment.socketUrl, <String, dynamic>{
        'transports': ['polling'],
        'autoConnect': false,
        'forceNew': true,
        'extraHeaders': {
          'x-token': token,
          'room': room,
        }
      });
    } else {
      // for No Web => run with ".setTransports"...
      socket = IO.io(Environment.socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'forceNew': true,
        'extraHeaders': {
          'x-token': token,
          'room': room,
        }
      });
    }

    socket.connect();

    // Connect to websocket
    //socket.connect();
    socket.onConnect((data) => {
          print('Connected to socket server'),
          _serverStatus = ServerStatus.Online,
          //notifyListeners(),
        });

    socket.onDisconnect((data) => {
          print('Disconnected from socket server'),
          _serverStatus = ServerStatus.Offline,
          //notifyListeners(),
        });
/*
    _socket.on('connect', (_) {
      print('Connected to socket server');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket.on('disconnect', (_) {
      print('Disconnected from socket server');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

*/
  }

  void disconnect() {
    print('121222 Reconnecting socket...');
    socket.disconnect();
    print('211222121 Disconnected socket...');
  }
}
