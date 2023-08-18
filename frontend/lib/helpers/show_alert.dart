import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

showAlert(BuildContext context, String title, String subtitle) {
  if (kIsWeb || Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: [
                MaterialButton(
                  elevation: 5,
                  textColor: Colors.green,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                )
              ],
            ));
  }

  showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              )
            ],
          ));
}
