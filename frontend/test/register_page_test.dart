// import 'package:flutter/material.dart';
// import 'package:flutter_chat/widgets/logo.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_chat/pages/register_page.dart'; // Update this import to match your file structure
// import 'package:flutter_chat/services/auth_service.dart';
// import 'package:flutter_chat/services/socket.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// // Mock AuthService
// class MockAuthService extends Mock implements AuthService {}

// // Mock SocketService
// class MockSocketService extends Mock implements SocketService {}
// /// The main function is the entry point of a Dart program.

// void main() {
//   group('RegisterPage Widget Tests', () {
//     testWidgets('RegisterPage should build', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProvider<AuthService>(
//               create: (_) => MockAuthService(),
//             ),
//             ChangeNotifierProvider<SocketService>(
//               create: (_) => MockSocketService(),
//             ),
//           ],
//           child: MaterialApp(home: RegisterPage()),
//         ),
//       );

//       expect(find.byType(RegisterPage), findsOneWidget);
//     });

//     testWidgets('RegisterPage contains logo widget', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProvider<AuthService>(
//               create: (_) => MockAuthService(),
//             ),
//             ChangeNotifierProvider<SocketService>(
//               create: (_) => MockSocketService(),
//             ),
//           ],
//           child: MaterialApp(home: RegisterPage()),
//         ),
//       );

//       expect(find.byType(Logo), findsOneWidget);
//     });

//     // Add more test cases for other widgets and interactions as needed
//   });

//   group('_Form Widget Tests', () {
//     testWidgets('_Form should build', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProvider<AuthService>(
//               create: (_) => MockAuthService(),
//             ),
//             ChangeNotifierProvider<SocketService>(
//               create: (_) => MockSocketService(),
//             ),
//           ],
//           // child: MaterialApp(home: _Form()),
//         ),
//       );

//       // expect(find.byType(_Form), findsOneWidget);
//     });

//     testWidgets('TextFormFields should be present', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProvider<AuthService>(
//               create: (_) => MockAuthService(),
//             ),
//             ChangeNotifierProvider<SocketService>(
//               create: (_) => MockSocketService(),
//             ),
//           ],
//           // child: MaterialApp(home: _Form()),
//         ),
//       );

//       expect(find.byType(TextFormField), findsNWidgets(3));
//     });

//     // Add more test cases for other interactions and behaviors as needed
//   });
// }
