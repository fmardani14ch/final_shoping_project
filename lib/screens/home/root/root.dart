import 'package:flutter/material.dart';
import 'package:vesam_shop/screens/basket/basket.dart';
import 'package:vesam_shop/screens/home/home.dart';
import 'package:vesam_shop/screens/profile/profile.dart';
import 'package:vesam_shop/theme.dart';

int selected_index = 0;
Widget selected_screen = HOME();

class ROOT_SCREEN extends StatefulWidget {
  @override
  State<ROOT_SCREEN> createState() => _ROOT_SCREENState();
}

class _ROOT_SCREENState extends State<ROOT_SCREEN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selected_screen,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 15,
          selectedItemColor: APP_COLORS.primary_color_red,
          backgroundColor: Colors.white,
          currentIndex: selected_index,
          onTap: (value) {
            setState(() {
              selected_index = value;
              switch (value) {
                case 0:
                  selected_screen = HOME();
                  break;
                case 1:
                  selected_screen = BASKET();

                  break;
                case 2:
                  selected_screen = PROFILE();
                  break;
              }
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "صفخه اصلی"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: "سبد خرید"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: "اطاعات کاربری"),
          ]),
    );
  }
}
