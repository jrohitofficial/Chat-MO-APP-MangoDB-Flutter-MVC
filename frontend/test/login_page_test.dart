// import 'package:flutter/material.dart';
// import 'package:flutter_chat/widgets/logo.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_chat/pages/login_page.dart'; // Update this import to match your file structure
// import 'package:flutter_chat/services/auth_service.dart';
// import 'package:flutter_chat/services/socket.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// // Mock AuthService
// class MockAuthService extends Mock implements AuthService {}

// // Mock SocketService
// class MockSocketService extends Mock implements SocketService {}

// void main() {
//   group('LoginPage Widget Tests', () {
//     testWidgets('LoginPage should build', (WidgetTester tester) async {
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
//           child: MaterialApp(home: LoginPage()),
//         ),
//       );

//       expect(find.byType(LoginPage), findsOneWidget);
//     });

//     testWidgets('LoginPage contains logo widget', (WidgetTester tester) async {
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
//           child: MaterialApp(home: LoginPage()),
//         ),
//       );

//       expect(find.byType(Logo), findsOneWidget);
//     });

//     testWidgets('LoginPage contains _Form widget', (WidgetTester tester) async {
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
//           child: MaterialApp(home: LoginPage()),
//         ),
//       );

//       // expect(find.byType(_Form), findsOneWidget);
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

//       expect(find.byType(TextFormField), findsNWidgets(2)); // Only two TextFormFields in the _Form
//     });

//     testWidgets('Log In button works', (WidgetTester tester) async {
//       final authService = MockAuthService();
//       // when(authService.login(any, any)).thenAnswer((_) async => true);

//       await tester.pumpWidget(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProvider<AuthService>(
//               create: (_) => authService,
//             ),
//             ChangeNotifierProvider<SocketService>(
//               create: (_) => MockSocketService(),
//             ),
//           ],
//           // child: MaterialApp(home: _Form()),
//         ),
//       );

//       final logInButton = find.text('Log In');
//       expect(logInButton, findsOneWidget);

//       await tester.tap(logInButton);
//       await tester.pump();

//       // verify(authService.login(any, any)).called(1);
//       // You can add more assertions here based on your use case
//     });

//     // Add more test cases for other interactions and behaviors as needed
//   });
// }
