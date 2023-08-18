import 'package:flutter_chat/helpers/show_alert.dart';
import 'package:flutter_chat/pages/login_page.dart';
import 'package:flutter_chat/pages/users_page.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/services/socket.dart';
import 'package:flutter_chat/widgets/button_sign.dart';
import 'package:flutter_chat/widgets/input.dart';
import 'package:flutter_chat/widgets/login_register_button.dart';
import 'package:flutter_chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = 'Register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.grey[300],
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Logo(),
                const SizedBox(
                  height: 5,
                ),
                _Form(),
                const SizedBox(
                  height: 5,
                ),
                const LoginRegisterButton(
                  routeName: LoginPage.routeName,
                  label: 'Already have an Account?',
                  textButton: 'Log In then!',
                ),
                //const SizedBox(height: 50),
                const Text('Terms and conditions'),
                const Text('Developed By Rohit Jha'),
              ]),
        ),
      ),
    ));
  }
}

class _Form extends StatelessWidget {
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Center(
      child: Container(
        constraints: const BoxConstraints(minWidth: 180, maxWidth: 600),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(children: [
          Input(
            icon: Icons.perm_identity_outlined,
            placeholder: 'User',
            maxLength: 16,
            controller: userController,
          ),
          const SizedBox(
            height: 10,
          ),
          Input(
            icon: Icons.email_outlined,
            placeholder: 'Email',
            maxLength: 32,
            controller: emailController,
          ),
          const SizedBox(
            height: 10,
          ),
          Input(
            icon: Icons.lock_outlined,
            placeholder: 'Password',
            maxLength: 32,
            controller: passController,
            hidden: true,
          ),
          const SizedBox(
            height: 20,
          ),
          SignButton(
            label: 'Register',
            press: authService.logeando
                ? null
                : () async {
                    final msg = await authService.register(
                        userController.text.trim(),
                        emailController.text.trim(),
                        passController.text);
                    if (msg == true) {
                      socketService.connect("noroom");
                      Navigator.pushReplacementNamed(
                          context, UsersPage.routeName);
                    } else
                      showAlert(context, 'Register', msg);
                  },
          ),
        ]),
      ),
    );
  }
}
