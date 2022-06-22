import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsp_gate/cubit/member/member_state.dart';
import 'package:hsp_gate/repositories/member_repository.dart';

class MemberCubit extends Cubit<MemberState> {
  MemberCubit() : super(InitialMemberState());

  MemberRepository memberRepository = MemberRepository();

  void getMember(String id) async {
    emit(LoadingGetMemberState());

    await Future.delayed(const Duration(seconds: 1));

    memberRepository.memberById(id).then((resp) async {
      emit(GetMemberState(resp));
    });
  }

  void scanMember(String id) async {
    emit(LoadingGetMemberState());

    await Future.delayed(const Duration(seconds: 1));

    memberRepository.scanMemberById(id).then((resp) async {
      // if (resp.success == true) {

      // }

      emit(GetScanMemberState(resp));
    });
  }
}
