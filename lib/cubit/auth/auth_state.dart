import 'package:equatable/equatable.dart';
import 'package:hsp_gate/models/auth/login/login_response.dart';
import 'package:hsp_gate/models/auth/password/password_response.dart';
import 'package:hsp_gate/models/auth/register/register_response.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

//FOR USER LOGIN
class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class AvailableAuthState extends AuthState {}

class SuccessAuthState extends AuthState {
  final LoginResponse loginResponse;

  SuccessAuthState(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];

  @override
  String toString() {
    return loginResponse.success.toString();
  }
}

class FailureAuthState extends AuthState {
  final String errorMessage;

  FailureAuthState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureAuthState{errorMessage: $errorMessage}';
  }
}
//END FOR USER LOGIN

//FOR REGISTER
class InitialRegisterState extends AuthState {}

class LoadingRegisterState extends AuthState {}

class CekLoginStatusState extends AuthState {}

class FailureRegisterState extends AuthState {
  final String errorMessage;

  FailureRegisterState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureRegisterState{errorMessage: $errorMessage}';
  }
}

class SuccessRegisterState extends AuthState {
  final RegisterResponse registerResponse;

  SuccessRegisterState(this.registerResponse);

  @override
  List<Object> get props => [registerResponse];

  @override
  String toString() {
    return "Success Register";
  }
}
//END FOR REGISTER

//FOR UPDATE PASSWORD
class InitialUpdatePasswordState extends AuthState {}

class InitialLoadingUpdatePasswordState extends AuthState {}

class FailedPasswordState extends AuthState {
  final String errorMessage;

  FailedPasswordState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return "FailedPasswordState";
  }
}

class SuccessPasswordState extends AuthState {
  final PasswordResponse passwordResponse;

  SuccessPasswordState(this.passwordResponse);

  @override
  List<Object> get props => [passwordResponse];

  @override
  String toString() {
    return 'SuccessPasswordState';
  }
}
//END FOR UPDATE PASSWORD