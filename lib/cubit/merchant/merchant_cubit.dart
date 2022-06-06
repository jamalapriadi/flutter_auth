import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/cubit/merchant/merchant_state.dart';
import 'package:flutter_login/repositories/merchant_repository.dart';

class MerchantCubit extends Cubit<MerchantState> {
  MerchantCubit() : super(InitialMerchantState());

  MerchantRepository merchantRepository = MerchantRepository();

  void getMerchant() async {
    emit(LoadingMerchantState());

    await Future.delayed(const Duration(seconds: 1));

    merchantRepository.getAll().then((resp) async {
      emit(GetMerchantState(resp));
    });
  }

  void setMerchant(String id) async {
    emit(LoadingSetMerchantState());

    merchantRepository.merchantById(id).then((res) async {
      merchantRepository.setSelectedMerchant(id);
      merchantRepository.setMerchant(res);
      emit(SuccessSetMerchantState("Set Merchant Success"));
    });
  }

  void getMerchantById() async {
    emit(LoadingGetMerchantByIdState());

    merchantRepository.getMerchant().then((res) async {
      emit(GetMerchantByIdState(res));
    });
  }
}
