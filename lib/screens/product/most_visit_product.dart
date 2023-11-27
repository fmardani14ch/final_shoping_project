import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:vesam_shop/data/local/favorite_product.dart';
import 'package:vesam_shop/data/models/home.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/screens/basket/bloc/basket_bloc.dart';

import 'package:vesam_shop/screens/home/home.dart';
import 'package:vesam_shop/screens/product/bloc/product_bloc.dart';
import 'package:vesam_shop/screens/product/product_detail.dart';
import 'package:vesam_shop/utils/customalert.dart';
import 'package:vesam_shop/utils/navigator.dart';

class MOST_VISITED_PRODUCT extends StatefulWidget {
  @override
  State<MOST_VISITED_PRODUCT> createState() => _MOST_VISITED_PRODUCTState();
  const MOST_VISITED_PRODUCT({super.key});
}

var like = Icon(
  Icons.favorite_outline,
  color: Colors.redAccent,
);
bool is_like = false;

class _MOST_VISITED_PRODUCTState extends State<MOST_VISITED_PRODUCT> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ProductBloc>(context).add(POPULAR_PRODUCT_START());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ////////////////////////////////////////////////////////////////
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              goto(context, HOME());
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
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
      /////////////////////////////////////////////////////////    app bar
      body: Container(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is POPULAR_PRODUCT_SUCCESS) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Expanded(
                            child: Text(
                          " پر بازدیدترین محصولات",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                      ],
                    ),
                    Expanded(
                        child: GridView.builder(
                      itemCount: state.product_model.products!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 270, crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        var product = state.product_model.products![index];

                        return SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                          child: GestureDetector(
                                            onTap: () {
                                              goto(
                                                  context,
                                                  PRODUCT_DETAIL(PRODUCT(
                                                    discountPrice:
                                                        product.discountPrice,
                                                    hasDiscount:
                                                        product.hasDiscount,
                                                    id: product.id,
                                                    image: product.image,
                                                    title: product.title,
                                                    price: product.price,
                                                    discountPercent:
                                                        product.discountPercent,
                                                  )));
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://flutter.vesam24.com/${product.image}",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CupertinoActivityIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Center(
                                                child: Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              if (FAVORITE_PRODUCT
                                                  .isinbox(product)) {
                                                setState(() {
                                                  FAVORITE_PRODUCT
                                                      .remove_product(product);
                                                });
                                              } else {
                                                setState(() {
                                                  FAVORITE_PRODUCT
                                                      .add_product(product);
                                                });
                                              }
                                            },
                                            icon: FAVORITE_PRODUCT
                                                    .isinbox(product)
                                                ? Icon(
                                                    Icons.favorite_sharp,
                                                    color: Colors.redAccent,
                                                  )
                                                : Icon(
                                                    Icons.favorite_outline,
                                                  )),
                                      ],
                                    ),
                                    SizedBox(
                                        child: Text(
                                      product.title.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ],
                                ),
                              ),
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
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Color.fromARGB(
                                                      255, 143, 138, 120),
                                                  fontWeight: FontWeight.w800),
                                            )
                                          : SizedBox(
                                              child: Text(
                                                  product.price!
                                                      .toString()
                                                      .seRagham(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800)),
                                              height: 5,
                                            ),
                                      product.hasDiscount!
                                          ? Text(
                                              product.discountPrice!
                                                      .toStringAsFixed(0)
                                                      .seRagham() +
                                                  "  تومان",
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 75, 73, 66),
                                                  fontWeight: FontWeight.w800),
                                            )
                                          : Text(
                                              product.price!
                                                      .toStringAsFixed(0)
                                                      .seRagham() +
                                                  "  تومان",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800),
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
                                                BlocProvider.of<BasketBloc>(
                                                        context)
                                                    .add(ADD_TO_BASKET_START(
                                                        product.id!));
                                              },
                                              color: Colors.redAccent,
                                              icon: Icon(Icons.add_circle))
                                          : SizedBox()),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ))
                  ],
                ),
              );
            } else if (state is POPULAR_PRODUCT_ERROR) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
