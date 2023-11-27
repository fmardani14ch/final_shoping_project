import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesam_shop/data/models/home.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/account/authentication.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/screens/basket/basket.dart';
import 'package:vesam_shop/screens/home/bloc/home_bloc.dart';
import 'package:vesam_shop/screens/home/home.dart';
import 'package:vesam_shop/screens/profile/user_favorit.dart';
import 'package:vesam_shop/screens/profile/user_payment.dart';
import 'package:vesam_shop/screens/profile/user_comments.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/customalert.dart';
import 'package:vesam_shop/utils/navigator.dart';

class PROFILE extends StatefulWidget {
  @override
  State<PROFILE> createState() => _PROFILEState();
}

int selected_index = 0;

class _PROFILEState extends State<PROFILE> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                  goto(context, HOME());
                  setState(() {
                    selected_index = 0;
                  });
                  break;

                case 1:
                  setState(() {
                    selected_index = 1;
                  });
                  if (login == true) {
                    goto(context, BASKET());
                  } else {
                    goto(context, AUTHENTICATION());
                  }
                  break;
                case 2:
                  setState(() {
                    selected_index = 2;
                  });
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
      appBar: AppBar(
        title: Text(
          "اطلاعات کاربری",
          style: TextStyle(color: APP_COLORS.primary_color_black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: 40,
                      color: Colors.black,
                    ),
                    radius: 50,
                    backgroundColor: Color.fromARGB(255, 211, 195, 195),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    fullname,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  Text(
                    phonenumber,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      goto(context, USER_MY_COMMENTS(PRODUCT()));
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.message_outlined,
                      color: Color.fromARGB(255, 80, 80, 80),
                    ),
                    title: Text(
                      "نظرات من",
                      style: TextStyle(
                          color: Color.fromARGB(255, 80, 80, 80),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    trailing: Icon(Icons.chevron_right_rounded),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      goto(context, USER_FAVORIT());
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.favorite_border_outlined,
                      color: Color.fromARGB(255, 80, 80, 80),
                    ),
                    title: Text(
                      "لیست مورد علاقه ها",
                      style: TextStyle(
                          color: Color.fromARGB(255, 80, 80, 80),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    trailing: Icon(Icons.chevron_right_rounded),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      goto(context, USER_PAYMENT());
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.payment_outlined,
                      color: Color.fromARGB(255, 80, 80, 80),
                    ),
                    title: Text(
                      "پرداخت های من",
                      style: TextStyle(
                          color: Color.fromARGB(255, 80, 80, 80),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    trailing: Icon(Icons.chevron_right_rounded),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  Center(
                      child: TextButton.icon(
                    label: Text(
                      "خروج از حساب کاربری",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onPressed: () async {
                      error_alert(context, "از حساب کاربری خارج شدید");
                      goto(context, AUTHENTICATION());

                      setState(() {
                        login = false;

                        current_user = null;
                      });
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.redAccent,
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
