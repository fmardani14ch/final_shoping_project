import 'package:flutter/material.dart';

class APP_COLORS {
  static const Color primary_color_green = Colors.greenAccent;
  static const Color primary_color_blue = Colors.blueAccent;
  static const Color primary_color_red = Colors.redAccent;
  static const Color primary_color_black = Colors.black;
  static const Color primary_color_grey = Colors.grey;
  static const Color primary_color_white = Colors.white;
}

ThemeData light_theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "yekan",
      platform: TargetPlatform.iOS,
      appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
      textTheme: TextTheme(
          displayMedium: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontSize: 12),
          labelSmall:
              TextStyle(fontSize: 10, color: APP_COLORS.primary_color_grey)));
}
