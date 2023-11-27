import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vesam_shop/screens/profile/bloc/profile_bloc.dart';
import 'package:vesam_shop/screens/profile/payment_detail.dart';
import 'package:vesam_shop/screens/profile/profile.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/date_time_formater.dart';
import 'package:vesam_shop/utils/navigator.dart';

class USER_PAYMENT extends StatefulWidget {
  @override
  State<USER_PAYMENT> createState() => _USER_PAYMENTState();
}

class _USER_PAYMENTState extends State<USER_PAYMENT> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(MY_PAYMENT_SUCCESS_START());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              goto(context, PROFILE());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Text(
          " پرداخت های من",
          style: TextStyle(color: APP_COLORS.primary_color_black),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is MY_PAYMENT_SUCCESS) {
            return state.success_payment.isEmpty
                ? Center(
                    child: Image.asset("assets/images/empty.png"),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      var dat = state.success_payment[index];
                      return InkWell(
                        onTap: () {
                          goto(context, PAYMENT_DETAIL(dat));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 192, 188, 188),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "شماره فاکتور",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Spacer(),
                                        Text(
                                          dat.factorCode.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "نام خریدار",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Spacer(),
                                        Text(
                                          dat.receiverFullName.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "تاریخ خرید",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${date_convert_to(dat.createDate!).$2} _ ${date_convert_to(dat.createDate!).$1}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "کد پستی",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Spacer(),
                                        Text(
                                          dat.receiverPostalCode.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: state.success_payment.length);
          } else if (state is MY_COMMENT_ERROR) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
