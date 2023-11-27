import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vesam_shop/data/models/home.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/screens/basket/bloc/basket_bloc.dart';
import 'package:vesam_shop/screens/home/home.dart';
import 'package:vesam_shop/screens/home/widget/prodoct_detail_slider.dart';
import 'package:vesam_shop/screens/home/widget/product_comments.dart';
import 'package:vesam_shop/screens/product/bloc/product_bloc.dart';
import 'package:vesam_shop/utils/customalert.dart';

import 'package:vesam_shop/utils/navigator.dart';

class PRODUCT_DETAIL extends StatefulWidget {
  const PRODUCT_DETAIL(this.product);
  final PRODUCT product;
  @override
  State<PRODUCT_DETAIL> createState() => _PRODUCT_DETAILState();
}

class _PRODUCT_DETAILState extends State<PRODUCT_DETAIL> {
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ProductBloc>(context)
        .add(PRODUCT_DETAIL_START(widget.product.id!));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.product.id!);
    // TODO: implement build
    return Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: login == true
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          success_alert(
                              context, "محصول با موفقیت به سبد خرید افزوده شد");
                          BlocProvider.of<BasketBloc>(context)
                              .add(ADD_TO_BASKET_START(widget.product.id!));
                          print("adding");
                        },
                        child: Text(
                          "افزودن به سبد خرید",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      SizedBox(
                        height: 70,
                        child: Column(
                          children: [
                            Text(
                              widget.product.price!
                                  .toStringAsFixed(0)
                                  .seRagham(),
                              style: TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(
                              widget.product.discountPrice!
                                  .toStringAsFixed(0)
                                  .seRagham(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red),
                  child: SizedBox(
                    height: 70,
                    child: Column(
                      children: [
                        Text(
                          widget.product.price!.toStringAsFixed(0).seRagham(),
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          widget.product.discountPrice!
                                  .toStringAsFixed(0)
                                  .seRagham() +
                              "  تومان",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 25),
                        )
                      ],
                    ),
                  ),
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
          title: const Text(
            "جزئیات محصول ",
            style: TextStyle(color: Colors.black, fontFamily: "yekan"),
          ),
        ),
        /////////////////////////////////////////////////////////////////////

        //////////////////////////////////////////////////////////////////

        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is PRODUCT_DETAIL_SUCCESS) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    PRODUCT_DETAIL_IMAGE_SLIDER(state.commentss),
                    SizedBox(
                      child: Text(
                        widget.product.title.toString(),
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    Divider(),
                    PRODUCT_COMMENTS(state.commentss)
                  ],
                ),
              );
            } else if (state is PRODUCT_DETAIL_ERROR) {
              return Center(
                child: Text("خطای نا مشخص"),
              );
            } else {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ));
  }
}
