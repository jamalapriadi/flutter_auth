import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/cubit/checkin/checkin_state.dart';
import 'package:flutter_login/models/checkin/checkin_request.dart';
import 'package:flutter_login/repositories/me_repository.dart';

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
