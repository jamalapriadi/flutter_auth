import 'package:equatable/equatable.dart';
import 'package:hsp_gate/models/auth/default_response.dart';
import 'package:hsp_gate/models/checkin/checkin.dart';

abstract class CheckinState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialCheckinState extends CheckinState {}

class LoadingCheckinState extends CheckinState {}

class SuccessCheckinState extends CheckinState {
  final DefaultResponse resp;

  SuccessCheckinState(this.resp);

  @override
  List<Object> get props => [resp];
}

class GetListCheckinState extends CheckinState {
  final List<Checkin> checkinList;

  GetListCheckinState(this.checkinList);

  @override
  List<Object> get props => [checkinList];
}
