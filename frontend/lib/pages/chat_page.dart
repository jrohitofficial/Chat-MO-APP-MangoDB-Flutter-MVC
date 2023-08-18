import 'dart:io';

import 'package:flutter_chat/models/message.dart';
import 'package:flutter_chat/models/user_model.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/services/chat_service.dart';
import 'package:flutter_chat/services/socket.dart';
import 'package:flutter_chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ChatPage extends StatefulWidget {
  static const routeName = 'Chat';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textControler = TextEditingController();
  bool writing = false;
  final _focus = FocusNode();

  final List<ChatMessage> _items = [];

  late User otherUser;
  late SocketService socketService;
  late AuthService authService;
  late ChatService chatService;

  late bool isIos;

  @override
  void initState() {
    super.initState();
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    chatService = Provider.of<ChatService>(context, listen: false);

    otherUser = chatService.userFrom; // from users_page : chatService.userFrom

    // Socket Change Room if it is a Group Chat
    if (otherUser.email == "na => Group Chat") {
      // Group Chat => Change room Mesage sent to server
      print('Enter Room = ${otherUser.uid}');
      socketService.socket.emit('message', {
        'changeroom': true,
        'leaveRoom': authService.user.uid, // User Id
        'joinRoom': otherUser.uid, // Room Id
      });
    }

    socketService.socket.on('message', _listenMessage);

    isIos = false;

    if (!kIsWeb) {
      if (Platform.isIOS) {
        isIos = true;
      }
    }
    //print(chatService.userFrom.uid);

    _loadingChat(chatService.userFrom.uid);
  }

  void _loadingChat(String uid) async {
    if (chatService.userFrom.email == "na => Group Chat") {
      uid = "AAA$uid";
      //print(uid);
    }

    List<Message> chat = await chatService.getChat(uid);
    final history = chat.map((m) => ChatMessage(
          text: m.message,
          uid: m.from,
          time: m.createdAt.toString().substring(0, 16),
          groupChat: m.groupChat, //
          name: m.name,
          anim: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 0))
            ..forward(),
        ));
    setState(() {
      _items.insertAll(0, history);
    });
  }

  void _listenMessage(dynamic data) {
    // Show received messages only if..
    //  1. it is a group message, and from different user
    //  2. from otherUser to this user
    if ((otherUser.email == "na => Group Chat" &&
            data['from'] != authService.user.uid) ||
        otherUser.uid == data['from']) {
      ChatMessage msj = ChatMessage(
        text: data['message'],
        uid: data['from'],
        time: data['time'],
        groupChat: data['groupChat'], //
        name: data['name'],
        anim: AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 500),
        ),
      );
      setState(() {
        _items.insert(0, msj);
      });
      msj.anim.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // On Exit Page > You can do some work here.
        // If Group Chat => Change Socket Room
        if (otherUser.email == "na => Group Chat") {
          //print('Leave Room = ${otherUser.uid}');
          // Group Chat => Change room Mesage sent to server
          socketService.socket.emit('message', {
            'changeroom': true,
            'leaveRoom': otherUser.uid, // Room Id
            'joinRoom': authService.user.uid, // User Id
          });
        }
        // Returning true allows the pop (exit page) to happen, returning false prevents it.
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor:  const Color.fromARGB(255, 0, 157, 200),
          title: Row(children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 145, 231, 255),
              child: Icon(
                (otherUser.email == "na => Group Chat")
                    ? Icons.group_rounded
                    : Icons.person_rounded,
                //color: (user.online) ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                otherUser.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  //color: Colors.blue[900],
                ),
              ),
            ),
          ]),
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/whatsapp_back.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _items[index];
                    },
                  ),
                ),
              ),
              const Divider(height: 2),
              _inputChat(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textControler,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Type Message'),
                focusNode: _focus,
                onSubmitted: writing
                    ? (_) => _handleSubmit(_)
                    : (_) => _textControler.clear(),
                onChanged: (text) {
                  if (text.trim().isNotEmpty) {
                    writing = true;
                  } else {
                    writing = false;
                  }
                  setState(() {});
                },
              ),
            ),
            Container(
                child: isIos
                    ? CupertinoButton(
                        onPressed: writing
                            ? () => _handleSubmit(_textControler.text)
                            : null,
                        child: const Text('Send'),
                      )
                    : IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: const Icon(Icons.send),
                        onPressed: writing
                            ? () => _handleSubmit(_textControler.text)
                            : null,
                      ))
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    _textControler.clear();
    _focus.requestFocus();

    final message = ChatMessage(
      text: text,
      uid: authService.user.uid,
      time: DateTime.now().toString().substring(0, 16),
      groupChat: otherUser.email == "na => Group Chat" ? true : false, //
      name: authService.user.name,
      anim: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      ),
    );

    _items.insert(0, message);
    message.anim.forward();

    setState(() {
      writing = false;
    });

    // Sedn message to socket server
    socketService.socket.emit('message', {
      'from': authService.user.uid,
      'to': otherUser.uid, // from users_page : chatService.userFrom
      'message': text,
      'groupChat': otherUser.email == "na => Group Chat" ? true : false,
      'name': authService.user.name,
      'time': DateTime.now().toString().substring(0, 16)
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _items) {
      message.anim.dispose();
    }
    _textControler.dispose();
    socketService.socket.off('message');
    super.dispose();
  }
}
