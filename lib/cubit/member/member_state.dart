import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/member/member_response.dart';

abstract class MemberState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialMemberState extends MemberState {}

class LoadingGetMemberState extends MemberState {}

class GetMemberState extends MemberState {
  final MemberResponse memberResponse;

  GetMemberState(this.memberResponse);

  @override
  List<Object> get props => [memberResponse];
}
