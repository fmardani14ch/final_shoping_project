import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vesam_shop/data/models/authentication.dart';
import 'package:vesam_shop/screens/account/authentication.dart';
import 'package:vesam_shop/screens/account/bloc/authentication_bloc.dart';
import 'package:vesam_shop/utils/customalert.dart';
import 'package:vesam_shop/utils/navigator.dart';

class REGISTER extends StatefulWidget {
  @override
  State<REGISTER> createState() => _REGISTERState();
}

TextEditingController fullnamecontroler = TextEditingController();
TextEditingController phonecontroler = TextEditingController();
TextEditingController emailcontroler = TextEditingController();
TextEditingController passwordcontroler = TextEditingController();

final keyvalid = GlobalKey<FormState>();
bool visi = true;

class _REGISTERState extends State<REGISTER> {
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
                    child: state is REGISTER_LOADING
                        ? CupertinoActivityIndicator()
                        : Text(
                            "ثبت نام",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w800),
                          ),
                    onPressed: () {
                      if (keyvalid.currentState!.validate()) {
                        AUTHENTICATION_MODEL authentication_model =
                            AUTHENTICATION_MODEL(
                                fullName: fullnamecontroler.text,
                                phoneNumber: phonecontroler.text,
                                email: emailcontroler.text,
                                password: passwordcontroler.text);
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(REGISTER_START(authentication_model));
                        fullnamecontroler.clear();
                        phonecontroler.clear();
                        emailcontroler.clear();
                        passwordcontroler.clear();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.greenAccent,
                          shape: OvalBorder(),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                          content: Text("ثبت نام با موفقیت انجام شد"),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.redAccent,
                          shape: OvalBorder(),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                          content: Text("خطا در ثبت نام   "),
                        ));
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "ثبت نام",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              Text("لطفا تمامی موارد زیر را با دقت تکمیل نمایید",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: keyvalid,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: fullnamecontroler,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "نام و نام خانوادگی را وارد نمایید";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text("نام و نام خانوادگی"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: phonecontroler,
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "شماره موبایل خود را وارد نمایید";
                          } else if (value!.startsWith("09") == false) {
                            return "شماره موبایل را به درستی وارد کنید";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text(" شماره موبایل"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailcontroler,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "ایمیل خورد را واد نمایید";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text(" ایمیل"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordcontroler,
                        obscureText: visi,
                        obscuringCharacter: "*",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "رمز عبور خود را وارد نمایید";
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
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
