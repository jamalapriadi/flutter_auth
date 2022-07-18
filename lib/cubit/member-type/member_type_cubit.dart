import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsp_gate/cubit/member-type/member_type_state.dart';
import 'package:hsp_gate/repositories/membertype_repository.dart';

class MembertypeCubit extends Cubit<MembertypeState> {
  MembertypeCubit() : super(InitialMembertypeState());

  MembertypeRepository membertypeRepository = MembertypeRepository();

  void getMembertype() async {
    emit(LoadingMembertypeState());

    await Future.delayed(const Duration(seconds: 1));

    membertypeRepository.getAll().then((resp) async {
      emit(GetMembertypeState(resp));
    });
  }
}
