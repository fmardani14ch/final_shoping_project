import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vesam_shop/data/models/basket.dart';
import 'package:vesam_shop/data/services/user_basket.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final BASKET_SERVICE basket_service;
  BasketBloc(this.basket_service) : super(BasketInitial()) {
    on<BasketEvent>((event, emit) async {
      if (event is ADD_TO_BASKET_START) {
        emit(ADD_TO_BASKET_LOADING());

        try {
          await basket_service.add_basket(event.product_id);
          emit(ADD_TO_BASKET_SUCCESS());
        } catch (e) {
          emit(ADD_TO_BASKET_ERROR("خطای نا مشخص"));
        }
      }
      if (event is GET_BASKET_START) {
        emit(GET_BASKET_LOADING());
        try {
          var response = await basket_service.get_all_basket();
          emit(GET_BASKET_SUCCESS(response));
        } catch (e) {
          emit(GET_BASKET_ERROR("خطای نا مشخص"));
        }
      }
      if (event is INCREAMENT_BASKET_START) {
        emit(INCREMENT_BASKET_LOADING());
        try {
          await basket_service.increase_to_basket(event.product_id);
          emit(INCREMENT_BASKET_SUCCESS());
        } catch (e) {
          emit(INCREMENT_BASKET_ERROR("خطای نا شناس"));
        }
      }
      if (event is DECREAMENT_BASKET_START) {
        emit(DECREMENT_BASKET_LOADING());
        try {
          await basket_service.decrease_from_basket(event.product_id);
          emit(DECREMENT_BASKET_SUCCESS());
        } catch (e) {
          emit(DECREMENT_BASKET_ERROR("خطای نا شناس"));
        }
      }
      if (event is DELETE_FROM_BASKET_START) {
        emit(DELETE_FROM_BASKET_LOADING());
        try {
          await basket_service.delete_from_basket(event.product_id);
          emit(DELETE_FROM_BASKET_SUCCESS());
        } catch (e) {
          emit(DELETE_FROM_BASKET_ERROR("خطای نا شناس"));
        }
      }
      if (event is PAY_BASKET_START) {
        emit(PAYMENT_BASKET_LOADING());
        try {
          var response = await basket_service.go_to_pay(event.payment);
          emit(PAYMENT_BASKET_SUCCESS(response));
        } catch (e) {
          emit(PAYMENT_BASKET_ERROR("خطای نا شناس"));
        }
      }
    });
  }
}
