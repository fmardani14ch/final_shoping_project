part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class LOGIN_START extends AuthenticationEvent {
  final AUTHENTICATION_MODEL authentication_model;
  LOGIN_START(this.authentication_model);
}

class REGISTER_START extends AuthenticationEvent {
  final AUTHENTICATION_MODEL authentication_model;
  REGISTER_START(this.authentication_model);
}
