import 'package:flutter_chat/models/room_model.dart';
import 'package:flutter_chat/pages/chat_page.dart';
import 'package:flutter_chat/pages/login_page.dart';
import 'package:flutter_chat/pages/newroom_page.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/services/chat_service.dart';
import 'package:flutter_chat/services/room_service.dart';
import 'package:flutter_chat/services/socket.dart';
import 'package:flutter_chat/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/models/user_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  static const routeName = 'Users';

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final usersService = UsersService();
  final roomsService = RoomService();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<User> users = [];
  List<Room> rooms = [];

  @override
  void initState() {
    _loadingUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).user;
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color.fromARGB(255, 200, 0, 0),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                socketService.disconnect();
                AuthService.deleteToken();
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              },
            ),

            /*
            FaIcon(FontAwesomeIcons.plug,
                color: (socketService.serverStatus == ServerStatus.Online)
                    ? Colors.green
                    : Colors.grey),
                    */
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // On click  => Open SelectContact page
        onPressed: () {
          Navigator.pushNamed(context, NewroomPage.routeName);
        },
        child: const Icon(Icons.group_add_rounded),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        header: const WaterDropHeader(
          waterDropColor: Colors.blue,
          complete: Icon(
            FontAwesomeIcons.check,
            color: Color.fromARGB(255, 255, 19, 19),
          ),
        ),
        onRefresh: _loadingUsers,
        child: ListView.separated(
          //shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: users.length + rooms.length + 2,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Container(
                alignment: Alignment.center,
                height: 32,
                width: 64,
                color: Color.fromARGB(255, 25, 21, 245),
                child: const Text(
                  'Rooms:',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else if (index <= rooms.length) {
              return RoomItem(rooms[index - 1]);
            } else if (index == rooms.length + 1) {
              return Container(
                alignment: Alignment.center,
                height: 32,
                width: 64,
                color: Color.fromARGB(255, 25, 21, 245),
                child: const Text(
                  'Users:',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return UserItem(users[index - rooms.length - 2]);
            }
          },
        ),

        /*
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                //shrinkWrap: false,
                physics: BouncingScrollPhysics(),
                itemCount: rooms.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) =>
                    RoomItem(rooms[index]),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * .8,
              height: 42,
              child: Container(
                alignment: Alignment.center,
                height: 32,
                width: 64,
                color: const Color.fromARGB(255, 145, 231, 255),
                child: const Text(
                  'Users:',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 24, 80, 164),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                //shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: users.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return UserItem(users[index]);
                },
              ),
            ),
          ],
        ),
        */
      ),
    );
  }

  void _loadingUsers() async {
    users = await usersService.getUsers();
    rooms = await roomsService.getRooms();
    _refreshController.refreshCompleted();
    setState(() {});
  }
}

class UserItem extends StatelessWidget {
  final User user;
  UserItem(
    this.user,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        user.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue[900],
        ),
      ),
      subtitle: Text(
        user.time.substring(0, 24),
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Color.fromARGB(255, 24, 80, 164),
        ),
      ),
      leading: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 145, 231, 255),
        child: Icon(
          Icons.person_rounded,
          //color: (user.online) ? Colors.green : Colors.red,
        ),
      ),
      trailing: Icon(
        Icons.check_circle_outline,
        color: (user.online) ? Colors.green : Colors.red,
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userFrom = user;
        Navigator.pushNamed(context, ChatPage.routeName);
      },
    );
  }
}

class RoomItem extends StatelessWidget {
  final Room room;
  RoomItem(
    this.room,
  );

  @override
  Widget build(BuildContext context) {
    //late User? user;
    //user = null;
    //print(room.groupname);
    //user.name = room.['groupname'];
    //user.uid = room.uid;

    return ListTile(
      title: Text(
        room.groupname,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue[900],
        ),
      ),
      subtitle: const Text(
        "Group Chat",
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: Color.fromARGB(255, 24, 80, 164),
        ),
      ),
      leading: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 145, 231, 255),
        child: Icon(
          Icons.group_rounded,
          //color: (user.online) ? Colors.green : Colors.red,
        ),
      ),
      /*
      trailing: Icon(
        Icons.check_circle_outline,
        color: (user.online) ? Colors.green : Colors.red,
      ),
      */
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userFrom = User(
          online: true,
          name: room.groupname,
          email: "na => Group Chat",
          uid: room.uid,
          time: "na",
        );
        Navigator.pushNamed(context, ChatPage.routeName);
      },
    );
  }
}
