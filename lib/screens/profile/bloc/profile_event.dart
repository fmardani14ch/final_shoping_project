part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class MY_COMMENTS_START extends ProfileEvent {}

class MY_PAYMENT_SUCCESS_START extends ProfileEvent {}
