import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:vesam_shop/data/models/authentication.dart';
import 'package:vesam_shop/data/models/home.dart';
import 'package:vesam_shop/data/models/product.dart';
import 'package:vesam_shop/data/models/user_info.dart';
import 'package:vesam_shop/screens/account/authentication.dart';
import 'package:vesam_shop/screens/account/bloc/authentication_bloc.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/screens/home/home.dart';
import 'package:vesam_shop/screens/product/bloc/product_bloc.dart';
import 'package:vesam_shop/screens/profile/user_comments.dart';

import 'package:vesam_shop/utils/navigator.dart';

class DRAW_COMMENT extends StatefulWidget {
  final product_id;
  const DRAW_COMMENT(this.product_id);
  @override
  State<DRAW_COMMENT> createState() => _DRAW_COMMENTState();
}

var auth_user = AUTHENTICATION_MODEL();
TextEditingController commentsubject = TextEditingController();
TextEditingController commenttext = TextEditingController();
var mx_line = 5;

class _DRAW_COMMENTState extends State<DRAW_COMMENT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.red,
          child: TextButton(
              onPressed: () {
                if (keyvalid.currentState!.validate()) {
                  BlocProvider.of<ProductBloc>(context)
                      .add(SEND_COMMENT_START(Comments(
                    id: widget.product_id,
                    subject: commentsubject.text,
                    text: commenttext.text,
                    productId: widget.product_id,
                    userFullName: fullname,
                    userEmail: email,
                  )));
                }

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.greenAccent,
                  shape: OvalBorder(),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(5),
                  content: Text("نظر شما با موفقیت ثبت شد"),
                ));
                goto(context, USER_MY_COMMENTS(PRODUCT()));
              },
              child: Text(
                "ثبت نظر",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              goto(context, HOME());
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "ثبت نظر",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Form(
                key: keyvalid,
                child: Column(
                  children: [
                    TextFormField(
                      controller: commentsubject,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "لطفا عنوان را به درستی وارد کنید";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "عنوان نظر",
                          enabledBorder: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: commenttext,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "لطفا متن نظر را به درستی وارد کنید";
                        } else {
                          return null;
                        }
                      },
                      maxLines: mx_line,
                      decoration: InputDecoration(
                          labelText: "متن نظر",
                          enabledBorder: OutlineInputBorder()),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
