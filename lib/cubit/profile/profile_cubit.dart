import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/cubit/profile/profile_state.dart';
import 'package:flutter_login/models/auth/me/password/update_password_request.dart';
import 'package:flutter_login/models/auth/me/profile/update_profile_request.dart';
import 'package:flutter_login/repositories/me_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(InitialProfileState());

  MeRepository meRepository = MeRepository();
  void me() async {
    emit(LoadingGetProfileState());

    await Future.delayed(const Duration(seconds: 3));

    meRepository.me().then((resp) async {
      meRepository.setMe(resp);
      emit(GetProfileState(resp));
    });
  }

  void getMe() async {
    meRepository.getMe().then((resp) async {
      emit(GetProfileState(resp));
    });
  }

  void updatePassword(
      String current, String password, String passwordConfirmation) async {
    emit(LoadingUpdatePasswordState());

    await Future.delayed(const Duration(seconds: 3));

    UpdatePasswordRequest updatePasswordRequest = UpdatePasswordRequest(
        current: current,
        password: password,
        passwordConfirmation: passwordConfirmation);

    meRepository.updatePassword(updatePasswordRequest).then((resp) async {
      emit(DoUpdatePasswordState(resp));
    });
  }

  void updateProfile(UpdateProfileRequest request) async {
    emit(LoadingUpdateProfileState());

    await Future.delayed(const Duration(seconds: 3));

    meRepository.updateProfile(request).then((resp) async {
      emit(DoUpdateProfileState(resp));
    });
  }

  void logout() async {
    meRepository.signOut();
  }
}
