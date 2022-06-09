import 'package:equatable/equatable.dart';
import 'package:hsp_gate/models/merchant/merchant_response.dart';

abstract class MerchantState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialMerchantState extends MerchantState {}

class LoadingMerchantState extends MerchantState {}

class GetMerchantState extends MerchantState {
  final List<MerchantResponse> merchantResponse;

  GetMerchantState(this.merchantResponse);

  @override
  List<Object> get props => [merchantResponse];
}

class LoadingSetMerchantState extends MerchantState {}

class SuccessSetMerchantState extends MerchantState {
  final String message;

  SuccessSetMerchantState(this.message);

  @override
  List<Object> get props => [message];
}

class LoadingGetMerchantByIdState extends MerchantState {}

class GetMerchantByIdState extends MerchantState {
  final MerchantResponse merchantResponse;

  GetMerchantByIdState(this.merchantResponse);

  @override
  List<Object> get props => [merchantResponse];
}

class GetNamaMerchantState extends MerchantState {
  final String nama;

  GetNamaMerchantState(this.nama);

  @override
  List<Object> get props => [nama];
}
