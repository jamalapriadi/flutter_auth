import 'package:equatable/equatable.dart';
import 'package:hsp_gate/models/auth/default_response.dart';
import 'package:hsp_gate/models/auth/me/me_response.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialProfileState extends ProfileState {}

//GET PROFILE
class LoadingGetProfileState extends ProfileState {}

class GetProfileState extends ProfileState {
  final MeResponse meResponse;

  GetProfileState(this.meResponse);

  @override
  List<Object> get props => [meResponse];

  @override
  String toString() {
    return "Success Me Response";
  }
}
//END GET PROFILE

//UPDATE PROFILE
class LoadingUpdateProfileState extends ProfileState {}

class DoUpdateProfileState extends ProfileState {
  final DefaultResponse resp;

  DoUpdateProfileState(this.resp);

  @override
  List<Object> get props => [resp];
}
//END UPDATE PROFILE

//UPDATE FOTO
class LoadingUpdateFotoState extends ProfileState {}

class DoUpdateFotoState extends ProfileState {
  final DefaultResponse resp;

  DoUpdateFotoState(this.resp);

  @override
  List<Object> get props => [resp];
}
//END UPDATE FOTO

//UPDATE PASSWORD
class LoadingUpdatePasswordState extends ProfileState {}

class DoUpdatePasswordState extends ProfileState {
  final DefaultResponse resp;

  DoUpdatePasswordState(this.resp);

  @override
  List<Object> get props => [resp];
}
//END UPDATE PASSWORD