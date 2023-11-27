import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vesam_shop/data/models/product.dart';
import 'package:vesam_shop/data/services/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final PRODUCT_SERVICE product_service;
  ProductBloc(this.product_service) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is LATEST_PRODUCT_START) {
        emit(LATEST_PRODUCT_LOADING());
        try {
          var response = await product_service.latest_product_model();
          emit(LATEST_PRODUCT_SUCCESS(response));
        } catch (e) {
          emit(LATEST_PRODUCT_ERROR("خطای نا مشخص"));
        }
      }
      /////////////////////////////////////////////   latest

      if (event is POPULAR_PRODUCT_START) {
        emit(POPULAR_PRODUCT_LOADING());
        try {
          var response = await product_service.popular_product_model();
          emit(POPULAR_PRODUCT_SUCCESS(response));
        } catch (e) {
          emit(POPULAR_PRODUCT_ERROR("خطای نا مشخص"));
        }
      }
      ////////////////////////////////////////////    popular
      if (event is PRODUCT_DETAIL_START) {
        emit(PRODUCT_DETAIL_LOADNUG());
        try {
          var response =
              await product_service.product_detail_model(event.product_idd);

          emit(PRODUCT_DETAIL_SUCCESS(response));
        } catch (e) {
          emit(PRODUCT_DETAIL_ERROR("خطای نا مشخص"));
        }
      }
      ////////////////////////////////////////////    comments
      if (event is SEND_COMMENT_START) {
        emit(SEND_COMMENT_LOADING());
        try {
          await product_service.send_comment(event.comment);
          emit(SEND_COMMENT_SUCCESS());
        } catch (e) {
          emit(SEND_COMMENT_ERROR("خطای نا مشخص"));
        }
      }
    });
  }
}
