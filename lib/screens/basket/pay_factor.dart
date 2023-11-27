import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vesam_shop/data/models/basket.dart';
import 'package:vesam_shop/screens/account/authentication.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/screens/basket/basket.dart';
import 'package:vesam_shop/screens/basket/bloc/basket_bloc.dart';
import 'package:vesam_shop/screens/home/home.dart';
import 'package:vesam_shop/screens/profile/profile.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/navigator.dart';
import 'package:url_launcher/url_launcher.dart';

class PAY_FACTOR extends StatefulWidget {
  @override
  State<PAY_FACTOR> createState() => _PAY_FACTORState();
}

TextEditingController fullname_control = TextEditingController();
TextEditingController phone_control = TextEditingController();
TextEditingController email_control = TextEditingController();
TextEditingController address_control = TextEditingController();
int selected_index = 0;

class _PAY_FACTORState extends State<PAY_FACTOR> {
  @override
  Widget build(BuildContext context) {
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
                  setState(() {
                    selected_index = 0;
                  });
                  goto(context, HOME());

                  break;

                case 1:
                  setState(() {
                    selected_index = 1;
                  });
                  goto(context, BASKET());
                  break;
                case 2:
                  setState(() {
                    selected_index = 2;
                  });
                  if (login == false) {
                    goto(context, AUTHENTICATION());
                  } else {
                    goto(context, PROFILE());
                  }
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
          "  تکمبل خرید",
          style: TextStyle(color: APP_COLORS.primary_color_black),
        ),
      ),
      body: BlocListener<BasketBloc, BasketState>(
        listener: (context, state) {
          if (state is PAYMENT_BASKET_SUCCESS) {
            launchUrl(Uri.parse("https://flutter.vesam24.com${state.getaway}"),
                mode: LaunchMode.externalApplication);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: keyvalid,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "لطفا نام و نام خانوادگی خود را وارد نماید";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        controller: fullname_control,
                        decoration: InputDecoration(
                            labelText: "نام و نام خانوادگی",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11)
                        ],
                        controller: phone_control,
                        validator: (value) {
                          if (value!.isEmpty || value!.length < 11) {
                            return "لطفا شماره موبایل خود را به درستی وارد نماید";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "شماره موبایل",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "لطفا کد پستی خود را وارد نماید";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        controller: email_control,
                        decoration: InputDecoration(
                            labelText: "کد پستی",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "لطفا آدرس محل سکونت  خود را وارد نماید";
                            } else {
                              return null;
                            }
                          },
                          maxLines: 5,
                          keyboardType: TextInputType.text,
                          controller: address_control,
                          decoration: InputDecoration(
                              labelText: "آدرس",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Container(
                child: TextButton(
                    onPressed: () async {
                      if (keyvalid.currentState!.validate()) {
                        BlocProvider.of<BasketBloc>(context).add(
                            PAY_BASKET_START(PAYMENT(
                                receiverAddress: address_control.text,
                                receiverPhoneNumber: phone_control.text,
                                receiverFullName: fullname_control.text,
                                receiverPostalCode: email_control.text)));
                      }
                    },
                    child: Text(
                      "تایید و پرداخت",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    )),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent),
                height: 50,
                width: MediaQuery.of(context).size.width,
              ),
            )
          ],
        ),
      ),
    );
  }
}
