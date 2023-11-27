import 'package:flutter/material.dart';

void goto(BuildContext context, Widget screen) {
  Navigator.pop(context);
  Navigator.push((context), MaterialPageRoute(builder: (context) {
    return screen;
  }));
}
