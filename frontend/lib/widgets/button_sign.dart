import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final VoidCallback? press;
  final String label;

  const SignButton({
    required this.press,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5,
        primary: Colors.greenAccent[700],
      ),
      onPressed: press,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Center(
            child: Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        )),
      ),
    );
  }
}
