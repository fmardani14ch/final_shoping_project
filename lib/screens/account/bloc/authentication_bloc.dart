import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vesam_shop/data/models/authentication.dart';
import 'package:vesam_shop/data/services/authentication.dart';
import 'package:vesam_shop/data/services/home.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/screens/home/bloc/home_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  // ignore: non_constant_identifier_names
  final AUTHENTICATION_SERVICE authentication_service;
  final HOME_SERVICE home_service;
  AuthenticationBloc(this.authentication_service, this.home_service)
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is LOGIN_START) {
        emit(LOGIN_LOADING());
        try {
          var response = await authentication_service
              .login_user(event.authentication_model!);

          current_user = await home_service.get_user_info();
          login = true;

          emit(LOGIN_SUCCESS(key_token));
        } catch (e) {
          emit(LOGIN_ERROR("خطای نا مشخص"));
        }
      }
      if (event is REGISTER_START) {
        emit(REGISTER_LOADING());
        try {
          await authentication_service
              .register_user(event.authentication_model!);
          emit(REGISTER_SUCCESS());
        } catch (e) {
          emit(REGISTER_ERROR("خطای نا مشخص"));
        }
      }
    });
  }
}
