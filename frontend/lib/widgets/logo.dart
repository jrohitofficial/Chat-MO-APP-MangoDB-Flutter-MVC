import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320,
        child: Column(children: const [
          Image(
            image: AssetImage('assets/logo.png'),
            height: 160,
          ),
          //Text('Super Mesenger',style:TextStyle(fontSize: 30))
        ]),
      ),
    );
  }
}
