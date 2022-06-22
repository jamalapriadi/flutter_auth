import 'dart:convert';

import 'package:hsp_gate/helpers/cache_const.dart';
import 'package:hsp_gate/helpers/cache_storage.dart';
import 'package:hsp_gate/helpers/http_request.dart';
import 'package:hsp_gate/models/auth/default_response.dart';
import 'package:hsp_gate/models/auth/me/me_response.dart';
import 'package:hsp_gate/models/auth/me/password/update_password_request.dart';
import 'package:hsp_gate/models/auth/me/profile/update_profile_request.dart';
import 'package:hsp_gate/models/checkin/checkin.dart';
import 'package:hsp_gate/models/checkin/checkin_request.dart';

class MeRepository {
  final network = Network();

  static const String urlApi = 'https://hsp-api.kemanaya.com/api';

  Future<MeResponse> me() async {
    var url = urlApi + "/auth/me";

    final response = await network.getRequest(url);

    return meResponseSuccessFromJson(response.body);
  }

  Future<bool> setMe(MeResponse data) async {
    return await Cache.setCache(key: 'me', data: json.encode(data));
  }

  Future<MeResponse> getMe() async {
    return meResponseFromJsonList(await Cache.getCache(key: 'me'));
  }

  Future<MeResponse> cekToken() async {
    var url = urlApi + "/auth/me";

    final response = await network.getRequest(url);

    if (response.statusCode == 200) {
      return meResponseSuccessFromJson(response.body);
    } else {
      return meResponseFailedFromJson(response.body);
    }
  }

  Future<DefaultResponse> updatePassword(UpdatePasswordRequest request) async {
    final response = await network.postRequestForm(
        urlApi + '/auth/change-password', request.toJson());

    return defaultResponseFromJson(response.body);
  }

  Future<DefaultResponse> updateProfile(UpdateProfileRequest request) async {
    final response = await network.postRequestForm(
        urlApi + '/auth/update-info', request.toJson());

    return defaultResponseFromJson(response.body);
  }

  Future<DefaultResponse> userCheckin(CheckinRequest request) async {
    final response = await network.postRequestForm(
        urlApi + '/auth/checkin', request.toJson());

    return defaultResponseFromJson(response.body);
  }

  Future<List<Checkin>> userCheckinToday() async {
    final response = await network.getRequest(urlApi + '/auth/checkin');

    return checkinFromList(response.body);
  }

  Future<bool> signOut() async {
    await Cache.setCache(key: accessToken, data: '');
    await Cache.removeCache(key: 'me');

    return await Cache.setCacheBool(key: isLogin, data: false);
  }
}
