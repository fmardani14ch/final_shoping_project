import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:vesam_shop/data/local/favorite_product.dart';
import 'package:vesam_shop/data/models/home.dart';
import 'package:vesam_shop/screens/product/product_detail.dart';

import 'package:vesam_shop/screens/profile/profile.dart';
import 'package:vesam_shop/utils/navigator.dart';

class USER_FAVORIT extends StatefulWidget {
  @override
  State<USER_FAVORIT> createState() => _USER_FAVORITState();
}

class _USER_FAVORITState extends State<USER_FAVORIT> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                goto(context, PROFILE());
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: Text(
            " لیست مورد علاقه ها",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        body: ValueListenableBuilder(
            valueListenable: FAVORITE_PRODUCT.favorite_product_box.listenable(),
            builder: (context, productsx, child) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var product = productsx.values!.toList()[index];

                    return FAVORITE_PRODUCT.favorite_product_box.isEmpty
                        ? Center(
                            child: Text(
                            "شما کالای مورد علاقه ای ندارید",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey),
                          ))
                        : Container(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
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
                                          height: 100,
                                          width: 80,
                                        ),
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
                                                  height: 50,
                                                  child: Text(
                                                    product.title!,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                    maxLines: 2,
                                                  ))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    product.price!
                                                            .toStringAsFixed(0)
                                                            .seRagham() +
                                                        "  تومان",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                                  Text(
                                                    product.discountPrice!
                                                            .toStringAsFixed(0)
                                                            .seRagham() +
                                                        "  تومان",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  )
                                                ],
                                              ),
                                              Spacer(),
                                              Expanded(
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        setState(() {
                                                          FAVORITE_PRODUCT
                                                              .remove_product(
                                                                  product);
                                                        });
                                                      },
                                                      icon: Icon(Icons.delete)))
                                            ],
                                          )
                                        ],
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: productsx.length);
            }));
  }
}
