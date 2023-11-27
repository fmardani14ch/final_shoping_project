part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class LATEST_PRODUCT_SUCCESS extends ProductState {
  final PRODUCT_MODEL product_model;
  LATEST_PRODUCT_SUCCESS(this.product_model);
}

class LATEST_PRODUCT_LOADING extends ProductState {}

class LATEST_PRODUCT_ERROR extends ProductState {
  final String error;
  LATEST_PRODUCT_ERROR(this.error);
}
////////////////////////////////////////////////

class POPULAR_PRODUCT_SUCCESS extends ProductState {
  final PRODUCT_MODEL product_model;
  POPULAR_PRODUCT_SUCCESS(this.product_model);
}

class POPULAR_PRODUCT_LOADING extends ProductState {}

class POPULAR_PRODUCT_ERROR extends ProductState {
  final String error;
  POPULAR_PRODUCT_ERROR(this.error);
}

////////////////////////////////////////////////

class PRODUCT_DETAIL_SUCCESS extends ProductState {
  final COMMENTS commentss;
  PRODUCT_DETAIL_SUCCESS(this.commentss);
}

class PRODUCT_DETAIL_LOADNUG extends ProductState {}

class PRODUCT_DETAIL_ERROR extends ProductState {
  final String error;
  PRODUCT_DETAIL_ERROR(this.error);
}

////////////////////////////////////////////////

class SEND_COMMENT_SUCCESS extends ProductState {}

class SEND_COMMENT_LOADING extends ProductState {}

class SEND_COMMENT_ERROR extends ProductState {
  final String error;
  SEND_COMMENT_ERROR(this.error);
}
