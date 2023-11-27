import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:vesam_shop/data/models/user_info.dart';
import 'package:vesam_shop/data/services/user_basket.dart';
import 'package:vesam_shop/screens/account/authentication.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/screens/basket/bloc/basket_bloc.dart';
import 'package:vesam_shop/screens/basket/pay_factor.dart';
import 'package:vesam_shop/screens/home/home.dart';
import 'package:vesam_shop/screens/profile/profile.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/navigator.dart';

class BASKET extends StatefulWidget {
  @override
  State<BASKET> createState() => _BASKETState();
}

var expand = false;
double sizex = 100;
int selected_index = 1;

class _BASKETState extends State<BASKET> {
  @override
  void initState() {
    BlocProvider.of<BasketBloc>(context).add(GET_BASKET_START());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("login satate is : $login");
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
          " سبد خرید",
          style: TextStyle(color: APP_COLORS.primary_color_black),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            login == false
                ? Column(
                    children: [
                      SizedBox(
                        child: Image.asset("assets/images/login.jpg"),
                      ),
                      Text("لطفا وارد حساب کاربری خود شوید !",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontFamily: "yekan")),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        width: 200,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.redAccent,
                        ),
                        child: SizedBox(
                          child: TextButton(
                            child: Text(
                              "ورود به حساب کاربری",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              if (login == false) {
                                goto(context, LOGIN());
                              } else {
                                goto(context, BASKET()); // user_pannel
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  )
                : BlocConsumer<BasketBloc, BasketState>(
                    listener: (context, state) {
                      if (state is INCREMENT_BASKET_SUCCESS ||
                          state is DECREMENT_BASKET_SUCCESS ||
                          state is DELETE_FROM_BASKET_SUCCESS) {
                        setState(() {
                          BlocProvider.of<BasketBloc>(context)
                              .add(GET_BASKET_START());
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is GET_BASKET_SUCCESS) {
                        if (state.user_basket.items!.isEmpty) {
                          return Center(
                              child: Image.asset("assets/images/empty.png"));
                        } else {
                          return Column(
                            children: [
                              SizedBox(
                                height: 400,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Divider();
                                  },
                                  itemCount: state.user_basket.items!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    late var product_list =
                                        state.user_basket.items![index];
                                    return Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              "https://flutter.vesam24.com/${product_list.productImage}",
                                          height: 100,
                                          width: 70,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    maxLines: 2,
                                                    product_list.productTitle!,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                Spacer(),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        BlocProvider.of<
                                                                    BasketBloc>(
                                                                context)
                                                            .add(DELETE_FROM_BASKET_START(
                                                                product_list
                                                                    .productId!));
                                                      });
                                                    },
                                                    icon: Icon(Icons.delete))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                product_list.discountPrice! > 1
                                                    ? Column(
                                                        children: [
                                                          Text(
                                                            product_list.price!
                                                                    .toStringAsFixed(
                                                                        0)
                                                                    .seRagham() +
                                                                "  تومان",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    204,
                                                                    202,
                                                                    202),
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                          ),
                                                          Text(
                                                              product_list
                                                                      .finalPrice!
                                                                      .toStringAsFixed(
                                                                          0)
                                                                      .seRagham() +
                                                                  "  تومان",
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ))
                                                        ],
                                                      )
                                                    : Text(
                                                        product_list.price!
                                                                .toStringAsFixed(
                                                                    0)
                                                                .seRagham() +
                                                            "  تومان",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        )),
                                                Spacer(),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        BlocProvider.of<
                                                                    BasketBloc>(
                                                                context)
                                                            .add(INCREAMENT_BASKET_START(
                                                                product_list
                                                                    .productId!));
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.add_circle,
                                                      color: Colors.redAccent,
                                                    )),
                                                Text(
                                                  product_list.count!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 5, 5, 5),
                                                    child:
                                                        product_list.count! > 1
                                                            ? IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    BlocProvider.of<BasketBloc>(
                                                                            context)
                                                                        .add(DECREAMENT_BASKET_START(
                                                                            product_list.productId!));
                                                                  });
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .remove_circle,
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      117,
                                                                      115,
                                                                      115),
                                                                ))
                                                            : Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            5,
                                                                            5,
                                                                            5,
                                                                            5),
                                                                child: Icon(
                                                                  Icons
                                                                      .remove_circle,
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      117,
                                                                      115,
                                                                      115),
                                                                ),
                                                              ))
                                              ],
                                            )
                                          ],
                                        )),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Divider(),
                              Container(
                                  height: sizex,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (expand == false) {
                                                    expand = true;
                                                    sizex = 300;
                                                  } else {
                                                    expand = false;
                                                    sizex = 100;
                                                  }
                                                });
                                              },
                                              icon: expand == false
                                                  ? Icon(Icons.arrow_drop_up)
                                                  : Icon(
                                                      Icons.arrow_drop_down)),
                                          Text(
                                            expand == false
                                                ? "مشاهده فاکتور"
                                                : "بستن ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          AnimatedContainer(
                                              duration: Duration(seconds: 1),
                                              child: expand == false
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                          state.user_basket
                                                              .totalPrice!
                                                              .toStringAsFixed(
                                                                  0)
                                                              .seRagham(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        Text("  تومان",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        126,
                                                                        125,
                                                                        125),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700))
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                  " جمع کل",
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          126,
                                                                          125,
                                                                          125),
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                            ),
                                                            SizedBox(
                                                              width: 50,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  state.user_basket
                                                                          .totalPrice!
                                                                          .toStringAsFixed(
                                                                              0)
                                                                          .seRagham() +
                                                                      "  تومان",
                                                                  style: TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                  "مبلغ تخفیف",
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          126,
                                                                          125,
                                                                          125),
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                            ),
                                                            SizedBox(
                                                              width: 50,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  state.user_basket
                                                                          .totalDiscountPrice!
                                                                          .toStringAsFixed(
                                                                              0)
                                                                          .seRagham() +
                                                                      "  تومان",
                                                                  style: TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                  "    مبلغ نهایی",
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          126,
                                                                          125,
                                                                          125),
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                            ),
                                                            SizedBox(
                                                              width: 30,
                                                            ),
                                                            Text(
                                                                state.user_basket
                                                                        .totalFinalPrice!
                                                                        .toStringAsFixed(
                                                                            0)
                                                                        .seRagham() +
                                                                    "  تومان",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700)),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        )
                                                      ],
                                                    ))
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 300,
                                        child: TextButton(
                                          onPressed: () async {
                                            goto(context, PAY_FACTOR());
                                          },
                                          child: Text("تکمیل خرید",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 252, 252, 252),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.redAccent),
                                      )
                                    ],
                                  ))
                            ],
                          );
                        }
                      } else if (state is GET_BASKET_ERROR) {
                        return Center(
                          child: Text(state.error),
                        );
                      } else {
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                    },
                  )
          ],
        ),
      )),
    );
  }
}
