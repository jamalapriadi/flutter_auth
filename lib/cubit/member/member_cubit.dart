import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/cubit/member/member_state.dart';
import 'package:flutter_login/repositories/member_repository.dart';

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
}
