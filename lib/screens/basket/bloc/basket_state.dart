part of 'basket_bloc.dart';

@immutable
sealed class BasketState {}

final class BasketInitial extends BasketState {}

// add product to basket
class ADD_TO_BASKET_SUCCESS extends BasketState {}

class ADD_TO_BASKET_LOADING extends BasketState {}

class ADD_TO_BASKET_ERROR extends BasketState {
  final String error;
  ADD_TO_BASKET_ERROR(this.error);
}

// get basket list to show
class GET_BASKET_SUCCESS extends BasketState {
  final USER_BASKET user_basket;
  GET_BASKET_SUCCESS(this.user_basket);
}

class GET_BASKET_LOADING extends BasketState {}

class GET_BASKET_ERROR extends BasketState {
  final String error;
  GET_BASKET_ERROR(this.error);
}

/////////////////////////////////////////////
class INCREMENT_BASKET_SUCCESS extends BasketState {}

class INCREMENT_BASKET_LOADING extends BasketState {}

class INCREMENT_BASKET_ERROR extends BasketState {
  final String error;
  INCREMENT_BASKET_ERROR(this.error);
}

///////////////////////////////////////////////////
class DECREMENT_BASKET_SUCCESS extends BasketState {}

class DECREMENT_BASKET_LOADING extends BasketState {}

class DECREMENT_BASKET_ERROR extends BasketState {
  final String error;
  DECREMENT_BASKET_ERROR(this.error);
}

///////

class DELETE_FROM_BASKET_LOADING extends BasketState {}

class DELETE_FROM_BASKET_ERROR extends BasketState {
  final String error;
  DELETE_FROM_BASKET_ERROR(this.error);
}

class DELETE_FROM_BASKET_SUCCESS extends BasketState {}

///////////////////////////////////////////////////
class PAYMENT_BASKET_SUCCESS extends BasketState {
  final String getaway;
  PAYMENT_BASKET_SUCCESS(this.getaway);
}

class PAYMENT_BASKET_LOADING extends BasketState {}

class PAYMENT_BASKET_ERROR extends BasketState {
  final String error;
  PAYMENT_BASKET_ERROR(this.error);
}
