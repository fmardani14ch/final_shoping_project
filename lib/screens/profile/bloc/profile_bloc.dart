import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vesam_shop/data/models/user_info.dart';
import 'package:vesam_shop/data/services/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final PROFILE_SERVICE profile_service;
  ProfileBloc(this.profile_service) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is MY_COMMENTS_START) {
        emit(MY_COMMENT_LOADING());
        try {
          var response = await profile_service.get_my_comment();
          emit(MY_COMMENT_SUCCESS(response));
        } catch (e) {
          emit(MY_COMMENT_ERROR("خطای ناشناخته"));
        }
      }
      ////////////////////////////////////////////////////////////////////////
      if (event is MY_PAYMENT_SUCCESS_START) {
        emit(MY_PAYMENT_LOADING());
        try {
          var response = await profile_service.get_user_payment();
          emit(MY_PAYMENT_SUCCESS(response));
        } catch (e) {
          emit(MY_PAYMENT_ERROR("خطای ناشناخته"));
        }
      }
    });
  }
}
