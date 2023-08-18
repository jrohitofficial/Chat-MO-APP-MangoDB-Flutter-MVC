import 'package:flutter_chat/pages/login_page.dart';
import 'package:flutter_chat/pages/users_page.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/services/socket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  static final routeName = 'Loading';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center();
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final auth = await authService.logged();
    if (auth) {
      socketService.connect("noroom");
      //Navigator.pushReplacementNamed(context, UsersPage.routeName);
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => UsersPage(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      //Navigator.pushReplacementNamed(context, LoginPage.routeName);
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginPage(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
