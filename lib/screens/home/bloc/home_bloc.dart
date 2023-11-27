import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vesam_shop/data/models/home.dart';
import 'package:vesam_shop/data/models/user_info.dart';
import 'package:vesam_shop/data/services/home.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/account/loging.dart';

part 'home_event.dart';
part 'home_state.dart';

USER_INFO? current_user;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HOME_SERVICE home_service;
  HomeBloc(this.home_service) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HOME_SCREEN_STARTED) {
        emit(HOMELOADING());
        try {
          var response = await home_service.get_general_info();
          if (login == true) {
            current_user = await home_service.get_user_info();
          }
          emit(HOMESUCCESS(response));
        } catch (e) {
          emit(HOMEERROR("خطای ناشناس"));
        }
      }
    });
  }
}
