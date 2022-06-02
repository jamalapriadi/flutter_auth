import 'package:flutter_login/helpers/cache_const.dart';
import 'package:flutter_login/helpers/cache_storage.dart';
import 'package:flutter_login/helpers/http_request.dart';
import 'package:flutter_login/models/auth/default_response.dart';
import 'package:flutter_login/models/auth/me/me_response.dart';
import 'package:flutter_login/models/auth/me/password/update_password_request.dart';
import 'package:flutter_login/models/auth/me/profile/update_profile_request.dart';

class MeRepository {
  final network = Network();

  static const String urlApi = 'https://hsp-api.kemanaya.com/api';

  Future<MeResponse> me() async {
    var url = urlApi + "/auth/me";

    final response = await network.getRequest(url);

    return meResponseFromJson(response.body);
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

  Future<bool> signOut() async {
    await Cache.setCache(key: accessToken, data: '');

    return await Cache.setCacheBool(key: isLogin, data: false);
  }
}
