import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:vesam_shop/data/models/home.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/account/authentication.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/screens/basket/basket.dart';
import 'package:vesam_shop/screens/basket/bloc/basket_bloc.dart';
import 'package:vesam_shop/screens/home/bloc/home_bloc.dart';

import 'package:vesam_shop/screens/product/latest_product.dart';
import 'package:vesam_shop/screens/product/most_visit_product.dart';
import 'package:vesam_shop/screens/product/product_detail.dart';
import 'package:vesam_shop/screens/profile/profile.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/customalert.dart';

import 'package:vesam_shop/utils/navigator.dart';

int selected_index = 0;

class HOME extends StatefulWidget {
  @override
  State<HOME> createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  @override
  Widget build(BuildContext context) {
    print(login);
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
                  if (login == true) {
                    goto(context, PROFILE());
                  } else {
                    goto(context, AUTHENTICATION());
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
      ////////////////////////////////////////////////////////////////
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 50,
              width: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "نگین شاپ",
              style: TextStyle(color: Colors.black, fontFamily: "yekan"),
            )
          ],
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HOMESUCCESS) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                children: [
                  //////////////////////////////////////////////   slider
                  CarouselSlider(
                    items: state.home_model.slides!.map((i) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: "https://flutter.vesam24.com/${i.image}",
                          placeholder: (context, url) {
                            return const CupertinoActivityIndicator();
                          },
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                          fit: BoxFit.fill,
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                        autoPlay: true,
                        height: 150,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: const Duration(seconds: 2)),
                  ),
                  //////////////////////////////////////////// new
                  SizedBox(
                    height: 300,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("جدیدترین محصولات",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                )),
                            Spacer(),
                            TextButton(
                                onPressed: () {
                                  goto(context, LATEST_PRODUCT());
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      "مشاهده همه",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.red),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.blueAccent,
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        Expanded(
                            child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.home_model.news!.length,
                          itemBuilder: (context, index) {
                            var product = state.home_model.news![index];
                            return SizedBox(
                              width: 170,
                              child: GestureDetector(
                                onTap: () {
                                  goto(context, PRODUCT_DETAIL(product));
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://flutter.vesam24.com/${product.image}",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: CupertinoActivityIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: 170,
                                        child: Text(
                                          product.title.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            product.hasDiscount!
                                                ? Text(
                                                    product.price!
                                                            .toStringAsFixed(0)
                                                            .seRagham() +
                                                        "  تومان",
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Color.fromARGB(
                                                            255, 143, 138, 120),
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  )
                                                : SizedBox(
                                                    child: Text(
                                                        product.price!
                                                            .toString()
                                                            .seRagham(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    height: 5,
                                                  ),
                                            product.hasDiscount!
                                                ? Text(
                                                    product.discountPrice!
                                                            .toStringAsFixed(0)
                                                            .seRagham() +
                                                        "  تومان",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 75, 73, 66),
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  )
                                                : Text(
                                                    product.price!
                                                            .toStringAsFixed(0)
                                                            .seRagham() +
                                                        "  تومان",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                          ],
                                        ),
                                        Spacer(),
                                        Container(
                                            child: login == true
                                                ? IconButton(
                                                    onPressed: () {
                                                      success_alert(context,
                                                          "محصول با موفقیت به سبد خرید افزوده شد");
                                                      BlocProvider.of<
                                                                  BasketBloc>(
                                                              context)
                                                          .add(
                                                              ADD_TO_BASKET_START(
                                                                  product.id!));
                                                    },
                                                    color: Colors.redAccent,
                                                    icon:
                                                        Icon(Icons.add_circle))
                                                : SizedBox()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ))
                      ],
                    ),
                  ),

                  Divider(),
                  ////////////////////////////////////////////////// most visit
                  SizedBox(
                    height: 300,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("پربازدیدترین محصولات",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                )),
                            Spacer(),
                            TextButton(
                                onPressed: () {
                                  goto(context, MOST_VISITED_PRODUCT());
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      "مشاهده همه",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.red),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.blueAccent,
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        Expanded(
                            child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.home_model.mostVisited!.length,
                          itemBuilder: (context, index) {
                            var product = state.home_model.mostVisited![index];
                            return SizedBox(
                              width: 170,
                              child: GestureDetector(
                                onTap: () {
                                  goto(context, PRODUCT_DETAIL(product));
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://flutter.vesam24.com/${product.image}",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: CupertinoActivityIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: 170,
                                        child: Text(
                                          product.title.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            product.hasDiscount!
                                                ? Text(
                                                    product.price!
                                                            .toStringAsFixed(0)
                                                            .seRagham() +
                                                        "  تومان",
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Color.fromARGB(
                                                            255, 143, 138, 120),
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  )
                                                : SizedBox(
                                                    child: Text(
                                                        product.price!
                                                            .toString()
                                                            .seRagham(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    height: 5,
                                                  ),
                                            product.hasDiscount!
                                                ? Text(
                                                    product.discountPrice!
                                                            .toStringAsFixed(0)
                                                            .seRagham() +
                                                        "  تومان",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 75, 73, 66),
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  )
                                                : Text(
                                                    product.price!
                                                            .toStringAsFixed(0)
                                                            .seRagham() +
                                                        "  تومان",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800)),
                                          ],
                                        ),
                                        Spacer(),
                                        Container(
                                            child: login == true
                                                ? IconButton(
                                                    onPressed: () {},
                                                    color: Colors.redAccent,
                                                    icon:
                                                        Icon(Icons.add_circle))
                                                : SizedBox()),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ))
                      ],
                    ),
                  )
                ],

                ////////////////////////////////////////////////////////////
              ),
            );
          } else if (state is HOMEERROR) {
            return const Center(
              child: Text("خطای ناشناس"),
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
