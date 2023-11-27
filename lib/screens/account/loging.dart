import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vesam_shop/data/models/authentication.dart';
import 'package:vesam_shop/data/services/authentication.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/account/authentication.dart';
import 'package:vesam_shop/screens/account/bloc/authentication_bloc.dart';
import 'package:vesam_shop/screens/profile/profile.dart';
import 'package:vesam_shop/utils/http_client.dart';
import 'package:vesam_shop/utils/navigator.dart';

class LOGIN extends StatefulWidget {
  @override
  State<LOGIN> createState() => _LOGINState();
}

TextEditingController emailcontroler = TextEditingController();
TextEditingController passwordcontroler = TextEditingController();
bool visi = true;
var key_token = "";
var fullname = "";
var phonenumber = "";
var email = "";
bool login = false;

class _LOGINState extends State<LOGIN> {
//  get authentication_service => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.redAccent),
            child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return TextButton(
                    child: state is LOGIN_LOADING
                        ? CupertinoActivityIndicator()
                        : Text(
                            "ورود",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w800),
                          ),
                    onPressed: () async {
                      print(emailcontroler.text);
                      print(passwordcontroler.text);

                      if (keyvalid.currentState!.validate()) {
                        AUTHENTICATION_MODEL authentication_model =
                            AUTHENTICATION_MODEL(
                                email: emailcontroler.text.toString(),
                                password: passwordcontroler.text.toString());
                        var response = await http_client.post("accounts/login",
                            data: authentication_model.toJson());
                        var keytoken = response.data;

                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LOGIN_START(authentication_model));
                        setState(() {
                          key_token = keytoken['accessToken'];
                          loged_in_key.setString("token", key_token);

                          login = true;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.greenAccent,
                          shape: OvalBorder(),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                          content: Text("با موفقیت ورود کردید"),
                        ));
                        if (key_token == "") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.redAccent,
                            shape: OvalBorder(),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(5),
                            content:
                                Text(" نام کاربری یا رمز عبور نا درست است"),
                          ));
                        }
                        if (key_token != "") {
                          var get_user = await http_client.get("users/me");
                          fullname = get_user.data["fullName"];
                          phonenumber = get_user.data["phoneNumber"];
                          email = get_user.data["email"];
                          print("name is : $key_token");
                          goto(context, PROFILE());
                        }

                        /// or go to user_panel
                      }
                    });
              },
            ),
          )),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              goto(context, AUTHENTICATION());
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "ورود",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Text("برای ورود به نگین شاپ ، ایمل و رمز عبور خود را وارد کنید",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey)),
            SizedBox(
              height: 100,
            ),
            Form(
                key: keyvalid,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailcontroler,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ایمیل خورد را وارد نمایید";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text("ایمیل"),
                          suffixIcon: IconButton(
                              onPressed: () {}, icon: Icon(Icons.email))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordcontroler,
                      obscureText: visi,
                      obscuringCharacter: "*",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "رمز عبورصحیح نیست";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text("رمز عبور"),
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (visi == true) {
                                  setState(() {
                                    visi = false;
                                  });
                                } else {
                                  setState(() {
                                    visi = true;
                                  });
                                }
                              },
                              icon: Icon(Icons.visibility_outlined))),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
