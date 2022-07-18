import 'package:equatable/equatable.dart';
import 'package:hsp_gate/models/member-type/membertype_response.dart';

abstract class MembertypeState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialMembertypeState extends MembertypeState {}

class LoadingMembertypeState extends MembertypeState {}

class GetMembertypeState extends MembertypeState {
  final List<MembertypeResponse> membertypeResponse;

  GetMembertypeState(this.membertypeResponse);

  @override
  List<Object> get props => [membertypeResponse];
}
