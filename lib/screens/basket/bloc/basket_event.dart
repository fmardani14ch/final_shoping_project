part of 'basket_bloc.dart';

@immutable
sealed class BasketEvent {}

class ADD_TO_BASKET_START extends BasketEvent {
  final int product_id;
  ADD_TO_BASKET_START(this.product_id);
}

class GET_BASKET_START extends BasketEvent {}

class INCREAMENT_BASKET_START extends BasketEvent {
  final int product_id;
  INCREAMENT_BASKET_START(this.product_id);
}

class DECREAMENT_BASKET_START extends BasketEvent {
  final int product_id;
  DECREAMENT_BASKET_START(this.product_id);
}

class DELETE_FROM_BASKET_START extends BasketEvent {
  final int product_id;
  DELETE_FROM_BASKET_START(this.product_id);
}

class PAY_BASKET_START extends BasketEvent {
  final PAYMENT payment;
  PAY_BASKET_START(this.payment);
}
