import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/screens/home/bloc/home_bloc.dart';
import 'package:vesam_shop/screens/home/home.dart';
import 'package:vesam_shop/utils/customalert.dart';
import 'package:vesam_shop/utils/navigator.dart';

class SPLASH extends StatefulWidget {
  @override
  State<SPLASH> createState() => _SPLASHState();
}

bool connecting_mod = false;
var vpn = "";
final connectivity_Result = (Connectivity().checkConnectivity());

class _SPLASHState extends State<SPLASH> {
  void check_internet() async {
    final connectivity_Result = await (Connectivity().checkConnectivity());
    setState(() {
      if (connectivity_Result == ConnectivityResult.wifi ||
          connectivity_Result == ConnectivityResult.mobile ||
          connectivity_Result == ConnectivityResult.ethernet) {
        BlocProvider.of<HomeBloc>(context).add(HOME_SCREEN_STARTED());
        print("connected ");
        connecting_mod = true;
      } else {
        print("disconnected");
        connecting_mod = false;
      }
    });
  }

  @override
  void initState() {
    check_internet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HOMESUCCESS) {
            goto(context, HOME());
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'به اپلیکیشن',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    ' نگین شاپ ',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.redAccent),
                  ),
                  Text(
                    ' خوش آمدید',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Container(
                  child: connecting_mod == false
                      ? Column(
                          children: [
                            Container(
                              child:
                                  connectivity_Result == ConnectivityResult.vpn
                                      ? Text("فیلتر شکن خود را خاموش کنید")
                                      : Text("اتصال اینترنت خود را بررسی کنید"),
                            ),
                            TextButton(
                                onPressed: () {
                                  goto(context, SPLASH());
                                },
                                child: Text("تلاش مجدد"))
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            CupertinoActivityIndicator()
                          ],
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
