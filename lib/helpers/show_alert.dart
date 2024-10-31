import 'package:flutter/material.dart';

showAlertPersonilize(BuildContext context, String title, String subtitle) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            elevation: 5,
            textColor: Colors.blue,
            child: const Text('Ok'),
          )
        ],
      );
    },
  );
}
