import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;
  final String time;
  final bool groupChat;
  final String name;
  final AnimationController anim;

  const ChatMessage({
    required this.text,
    required this.uid,
    required this.time,
    required this.groupChat,
    required this.anim,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<AuthService>(context).user.uid;
    print(groupChat);
    return SizedBox(
      child: Column(
        children: [
          SizeTransition(
            sizeFactor: CurvedAnimation(parent: anim, curve: Curves.easeOut),
            child: Align(
              alignment:
                  (this.uid == uid) ? Alignment.topRight : Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                margin: EdgeInsets.only(
                    top: 5,
                    bottom: 0,
                    left: (this.uid == uid) ? 50 : 10,
                    right: (this.uid == uid) ? 10 : 50),
                decoration: BoxDecoration(
                    color: (this.uid == uid) ? Colors.blueAccent : Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: (this.uid == uid)
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    if (groupChat && this.uid != uid) ...[
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 19, 45, 20),
                        ),
                      ),
                    ],
                    Text(
                      text,
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment:
                (this.uid == uid) ? Alignment.topRight : Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: (this.uid == uid) ? 50 : 20,
                  right: (this.uid == uid) ? 20 : 50),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: (this.uid == uid) ? Colors.blueAccent : Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
