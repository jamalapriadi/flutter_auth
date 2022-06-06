import 'dart:convert';

import 'package:flutter_login/helpers/cache_const.dart';
import 'package:flutter_login/helpers/cache_storage.dart';
import 'package:flutter_login/helpers/http_request.dart';
import 'package:flutter_login/models/merchant/merchant_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantRepository {
  final network = Network();

  static const String urlApi = 'https://hsp-api.kemanaya.com/api';

  Future<List<MerchantResponse>> getAll() async {
    var url = urlApi + "/auth/merchant-user";

    final response = await network.getRequest(url);

    return merchantResponseFromJson(response.body);
  }

  Future<MerchantResponse> merchantById(id) async {
    var url = urlApi + "/auth/merchant/" + id;

    final response = await network.getRequest(url);

    return singleMerchantResponseFromJson(response.body);
  }

  Future<bool> setSelectedMerchant(String id) async {
    return await Cache.setCache(key: 'selectedmerchant', data: id);
  }

  Future<String> getSelectedMerchant() async {
    return await Cache.getCache(key: 'selectedmerchant');
  }

  Future<bool> setMerchant(MerchantResponse data) async {
    return await Cache.setCache(key: 'merchant', data: json.encode(data));
  }

  Future<MerchantResponse> getMerchant() async {
    return singleListMerchantResponseFromJson(
        await Cache.getCache(key: 'merchant'));
  }
}
