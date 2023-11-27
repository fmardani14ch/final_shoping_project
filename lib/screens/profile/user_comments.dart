import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vesam_shop/data/models/home.dart';
import 'package:vesam_shop/screens/product/latest_product.dart';

import 'package:vesam_shop/screens/product/product_detail.dart';
import 'package:vesam_shop/screens/profile/bloc/profile_bloc.dart';
import 'package:vesam_shop/screens/profile/profile.dart';
import 'package:vesam_shop/utils/date_time_formater.dart';
import 'package:vesam_shop/utils/navigator.dart';

class USER_MY_COMMENTS extends StatefulWidget {
  final PRODUCT product;
  USER_MY_COMMENTS(this.product);
  @override
  State<USER_MY_COMMENTS> createState() => _USER_MY_COMMENTSState();
}

class _USER_MY_COMMENTSState extends State<USER_MY_COMMENTS> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(MY_COMMENTS_START());

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
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "نظرات من",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is MY_COMMENT_SUCCESS) {
            return state.my_comments.isEmpty
                ? Center(
                    child: Image.asset("assets/images/empty_comment.jpg"),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      var dat = state.my_comments[index];

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              goto(
                                  context,
                                  PRODUCT_DETAIL(PRODUCT(
                                    discountPrice: product.discountPrice,
                                    hasDiscount: product.hasDiscount,
                                    id: product.id,
                                    image: product.image,
                                    title: product.title,
                                    price: product.price,
                                    discountPercent: product.discountPercent,
                                  )));
                            },
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://flutter.vesam24.com/${state.my_comments[index].productImage}",
                              width: 80,
                              height: 80,
                              placeholder: (context, url) => Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${dat.productTitle}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                    "${date_convert_to(dat.createDate!).$2}_${date_convert_to(dat.createDate!).$1}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                                Text("${dat.subject}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800)),
                                Text("${dat.text}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey))
                              ],
                            ),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: state.my_comments.length);
          } else if (state is MY_COMMENT_ERROR) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }
}
