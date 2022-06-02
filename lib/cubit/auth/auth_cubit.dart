import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/cubit/auth/auth_state.dart';
import 'package:flutter_login/models/auth/login/login_request.dart';
import 'package:flutter_login/models/auth/password/password_request.dart';
import 'package:flutter_login/models/auth/register/register_request.dart';
import 'package:flutter_login/repositories/auth_repository.dart';
import 'package:flutter_login/repositories/me_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());

  AuthRepository authRepository = AuthRepository();
  MeRepository meRepository = MeRepository();

  void login(String username, String password) async {
    emit(LoadingAuthState());

    await Future.delayed(const Duration(seconds: 3));

    LoginRequest loginRequest =
        LoginRequest(username: username, password: password, source: "login");

    authRepository.login(loginRequest).then((resp) async {
      // ignore: unrelated_type_equality_checks
      if (resp.success == true) {
        authRepository.setIsLogin(true);
        authRepository.setToken(resp.accessToken.toString());
        emit(SuccessAuthState(resp));
      } else {
        authRepository.setIsLogin(false);
        authRepository.setToken('');
        emit(FailureAuthState(resp.message.toString()));
      }
    });
  }

  void checkIfLogin() async {
    bool isLogin = await authRepository.cekIsLogin();

    if (isLogin == true) {
      //check if token expired or not
      emit(CekLoginStatusState());
      meRepository.cekToken().then((resp) async {
        if (resp == 200) {
          emit(AvailableAuthState());
        } else {
          emit(FailureAuthState('Login Gagal'));
        }
      });
    } else {
      emit(FailureAuthState('Login Gagal'));
    }
  }

  void register(RegisterRequest request) async {
    emit(LoadingRegisterState());

    await Future.delayed(const Duration(seconds: 3));

    authRepository.register(request).then((resp) async {
      if (resp.success == true) {
        emit(SuccessRegisterState(resp));
      } else {
        emit(FailureRegisterState(resp.message.toString()));
      }
    });
  }

  void password(PasswordRequest request) async {
    emit(InitialLoadingUpdatePasswordState());

    await Future.delayed(const Duration(seconds: 3));

    authRepository.password(request).then((resp) async {
      if (resp.success == true) {
        emit(SuccessPasswordState(resp));
      } else {
        emit(FailedPasswordState(resp.message.toString()));
      }
    });
  }

  void forgotPassword(String email) async {}

  void konfirmasiOtp(String otp) async {}
}
