part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

class LOGIN_SUCCESS extends AuthenticationState {
  final String accessToken;
  LOGIN_SUCCESS(this.accessToken);
}

class LOGIN_LOADING extends AuthenticationState {}

class LOGIN_ERROR extends AuthenticationState {
  final String error;
  LOGIN_ERROR(this.error);
}

///////////////////////////////////////////////
///
class REGISTER_SUCCESS extends AuthenticationState {}

class REGISTER_LOADING extends AuthenticationState {}

class REGISTER_ERROR extends AuthenticationState {
  final String error;
  REGISTER_ERROR(this.error);
}
