import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vesam_shop/data/models/product.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/screens/home/widget/draw_comment.dart';
import 'package:vesam_shop/utils/navigator.dart';

class PRODUCT_COMMENTS extends StatefulWidget {
  @override
  State<PRODUCT_COMMENTS> createState() => _PRODUCT_COMMENTSState();
  final COMMENTS product_comment;
  const PRODUCT_COMMENTS(this.product_comment);
}

bool is_expanded = false;
int mslne = 2;

class _PRODUCT_COMMENTSState extends State<PRODUCT_COMMENTS> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "توضیحات محصول",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            Text(
              widget.product_comment.description.toString(),
              maxLines: mslne,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: const Color.fromARGB(255, 116, 115, 115)),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    is_expanded ? "بستن" : "مشاهده بیشتر",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.redAccent),
                  ),
                  IconButton(
                      onPressed: () {
                        if (is_expanded == true) {
                          setState(() {
                            is_expanded = false;
                            mslne = 2;
                          });
                        } else {
                          setState(() {
                            is_expanded = true;
                            mslne = 10;
                          });
                        }
                      },
                      icon: is_expanded
                          ? Icon(Icons.arrow_drop_up)
                          : Icon(Icons.arrow_drop_down)),
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                Text(
                  "نظرات کاربران",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                Spacer(),
                TextButton(
                  child: login == true
                      ? Text(
                          "ثبت نظر",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13),
                        )
                      : SizedBox(),
                  onPressed: () {
                    goto(context, DRAW_COMMENT(widget.product_comment.id));
                  },
                )
              ],
            ),
            ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.product_comment.comments![index].subject
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            Spacer(),
                            Text(
                              widget.product_comment.comments![index].userEmail
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 12),
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            widget.product_comment.comments![index].text
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 90, 88, 88)),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: widget.product_comment.comments!.length)
          ],
        ),
      ),
    );
  }
}
