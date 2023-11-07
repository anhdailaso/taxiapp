import 'package:flutter/material.dart';

class MsgDialog {
  static void ShowMsgDialog(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(MsgDialog());
              },
              child: Text("OK")),
        ],
      ),
    );
  }
}
