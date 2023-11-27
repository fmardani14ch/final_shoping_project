import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vesam_shop/data/models/product.dart';
import 'package:vesam_shop/screens/product/bloc/product_bloc.dart';
import 'package:vesam_shop/screens/product/product_detail.dart';

class PRODUCT_DETAIL_IMAGE_SLIDER extends StatefulWidget {
  const PRODUCT_DETAIL_IMAGE_SLIDER(this.commentss);
  final COMMENTS commentss;
  @override
  State<PRODUCT_DETAIL_IMAGE_SLIDER> createState() =>
      _PRODUCT_DETAIL_IMAGE_SLIDERState();
}

class _PRODUCT_DETAIL_IMAGE_SLIDERState
    extends State<PRODUCT_DETAIL_IMAGE_SLIDER> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return CarouselSlider(
          items: widget.commentss.images!.map((i) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: "https://flutter.vesam24.com/${i}",
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
              autoPlayAnimationDuration: Duration(seconds: 2)),
        );
      },
    );
  }
}
