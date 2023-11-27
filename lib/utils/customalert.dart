import 'package:flutter/material.dart';

void success_alert(BuildContext context, String msg_text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.greenAccent,
    shape: OvalBorder(),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(5),
    content: Text(msg_text),
  ));
}

void error_alert(BuildContext context, String msg_text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.redAccent,
    shape: OvalBorder(),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(5),
    content: Text(msg_text),
  ));
}
