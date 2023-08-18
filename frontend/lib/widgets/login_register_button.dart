import 'package:flutter/material.dart';

class LoginRegisterButton extends StatelessWidget {
  final String routeName;
  final String textButton;
  final String label;

  const LoginRegisterButton({
    required this.routeName,
    required this.textButton,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        const SizedBox(height: 10),
        Text(label),
        const SizedBox(height: 10),
        GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, routeName),
            child: Text(textButton,
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 160, 5, 5),
                    fontWeight: FontWeight.bold))),
      ]),
    );
  }
}
