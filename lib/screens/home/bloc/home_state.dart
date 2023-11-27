part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HOMESUCCESS extends HomeState {
  final HOME_MODEL home_model;
  HOMESUCCESS(this.home_model);
}

class HOMEERROR extends HomeState {
  final String error;
  HOMEERROR(this.error);
}

class HOMELOADING extends HomeState {}
