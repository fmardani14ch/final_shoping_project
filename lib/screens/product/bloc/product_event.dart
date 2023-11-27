part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class LATEST_PRODUCT_START extends ProductEvent {}

class POPULAR_PRODUCT_START extends ProductEvent {}

class PRODUCT_DETAIL_START extends ProductEvent {
  final int product_idd;

  PRODUCT_DETAIL_START(this.product_idd);
}

class SEND_COMMENT_START extends ProductEvent {
  final Comments comment;
  SEND_COMMENT_START(this.comment);
}
