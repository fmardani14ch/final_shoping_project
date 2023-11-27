import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:vesam_shop/data/models/user_info.dart';
import 'package:vesam_shop/screens/profile/user_payment.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/date_time_formater.dart';
import 'package:vesam_shop/utils/navigator.dart';

class PAYMENT_DETAIL extends StatefulWidget {
  @override
  final SUCCESS_PAYMENT success_payment;
  PAYMENT_DETAIL(this.success_payment, {super.key});
  State<PAYMENT_DETAIL> createState() => _PAYMENT_DETAILState();
}

class _PAYMENT_DETAILState extends State<PAYMENT_DETAIL> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              goto(context, USER_PAYMENT());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Text(
          "جزئیات فاکتور ",
          style: TextStyle(color: APP_COLORS.primary_color_black),
        ),
      ),
      body: ListView.separated(
          itemBuilder: ((context, index) {
            var dat_setail = widget.success_payment.payment_factor![index];
            var dat = widget.success_payment;
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://flutter.vesam24.com/${dat_setail.productImage}",
                        height: 100,
                        width: 80,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 250,
                                child: Text(
                                  dat_setail.productTitle.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                " تعداد",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                              Spacer(),
                              Text(
                                dat_setail.count.toString() + " عدد",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                " تاریخ خرید",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                              Spacer(),
                              Text(
                                "${date_convert_to(dat.createDate!).$2} _ ${date_convert_to(dat.createDate!).$1}"
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                " قیمت نهایی",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                              Spacer(),
                              Text(
                                dat.factorCode.toString().seRagham() +
                                    "  تومان",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ))
                    ],
                  )
                ],
              ),
            );
          }),
          separatorBuilder: ((context, index) {
            return Divider();
          }),
          itemCount: widget.success_payment.payment_factor!.length),
    );
  }
}
