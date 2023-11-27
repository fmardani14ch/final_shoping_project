import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/screens/account/register.dart';
import 'package:vesam_shop/utils/navigator.dart';

import '../home/home.dart';

Color collog = Color.fromARGB(255, 248, 245, 245);
Color colreg = Color.fromARGB(255, 248, 245, 245);

class AUTHENTICATION extends StatefulWidget {
  @override
  State<AUTHENTICATION> createState() => _AUTHENTICATIONState();
}

final keyvalid = GlobalKey<FormState>();

class _AUTHENTICATIONState extends State<AUTHENTICATION> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.redAccent),
            child: TextButton(
                child: Text(
                  "به عنوان کاربر میهمان ادامه میدهم",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                onPressed: () {
                  goto(context, HOME());
                }),
          )),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'به',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '  نگین  ',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          color: Colors.redAccent),
                    ),
                    Text(
                      'شاپ خوش آمدید',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(child: Container(child: SizedBox())),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: colreg,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              goto(context, LOGIN());
                            },
                            child: Text(
                              "ورود",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: colreg,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              goto(context, REGISTER());
                            },
                            child: Text(
                              "ثبت نام",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
