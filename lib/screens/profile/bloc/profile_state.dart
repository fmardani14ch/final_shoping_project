part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class MY_COMMENT_SUCCESS extends ProfileState {
  final List<MY_COMMENTS> my_comments;
  MY_COMMENT_SUCCESS(this.my_comments);
}

class MY_COMMENT_LOADING extends ProfileState {}

class MY_COMMENT_ERROR extends ProfileState {
  final String error;
  MY_COMMENT_ERROR(this.error);
}

////////////////////////////////////////////////////////////////////////
class MY_PAYMENT_SUCCESS extends ProfileState {
  final List<SUCCESS_PAYMENT> success_payment;
  MY_PAYMENT_SUCCESS(this.success_payment);
}

class MY_PAYMENT_LOADING extends ProfileState {}

class MY_PAYMENT_ERROR extends ProfileState {
  final String error;
  MY_PAYMENT_ERROR(this.error);
}
