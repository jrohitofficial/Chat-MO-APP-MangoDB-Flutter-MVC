import 'package:flutter_chat/pages/accel.dart';
import 'package:flutter_chat/pages/loading_page.dart';
import 'package:flutter_chat/routes/routes.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/services/chat_service.dart';
import 'package:flutter_chat/services/room_service.dart';
import 'package:flutter_chat/services/socket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
  FlutterNativeSplash.remove();
  runApp(MyApp());
}

Future initialization(BuildContext? context) async {
  //  Load Resources
  await Future.delayed(Duration(seconds: 2));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => SocketService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatService(),
        ),
        ChangeNotifierProvider(
          create: (_) => RoomService(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(0xFF075E54),
          fontFamily: 'OpenSans',
        ),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: LoadingPage.routeName,
        routes: routes,
        home: AccelerometerScreen(),
      ),
    );
  }
}
