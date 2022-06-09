import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsp_gate/cubit/checkin/checkin_state.dart';
import 'package:hsp_gate/models/checkin/checkin_request.dart';
import 'package:hsp_gate/repositories/me_repository.dart';

class CheckinCubit extends Cubit<CheckinState> {
  CheckinCubit() : super(InitialCheckinState());

  MeRepository meRepository = MeRepository();

  void checkIn(CheckinRequest request) async {
    emit(LoadingCheckinState());

    await Future.delayed(const Duration(seconds: 3));

    meRepository.userCheckin(request).then((resp) async {
      emit(SuccessCheckinState(resp));
    });
  }

  void getCheckinToday() async {
    emit(LoadingCheckinState());

    await Future.delayed(const Duration(seconds: 3));

    meRepository.userCheckinToday().then((resp) async {
      emit(GetListCheckinState(resp));
    });
  }
}
