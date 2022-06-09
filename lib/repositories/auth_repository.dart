import 'package:hsp_gate/helpers/http_request.dart';
import 'package:hsp_gate/models/auth/login/login_request.dart';
import 'package:hsp_gate/models/auth/login/login_response.dart';
import 'package:hsp_gate/models/auth/password/password_request.dart';
import 'package:hsp_gate/models/auth/password/password_response.dart';
import 'package:hsp_gate/models/auth/register/register_request.dart';
import 'package:hsp_gate/models/auth/register/register_response.dart';

import '../helpers/cache_const.dart';
import '../helpers/cache_storage.dart';

class AuthRepository {
  final network = Network();

  static const String urlApi = 'https://hsp-api.kemanaya.com/api';

  Future<LoginResponse> login(LoginRequest request) async {
    var url = urlApi + "/login-gate";

    final response =
        await network.postRequestWithoutToken(url, request.toJson());

    return loginResponseFromJson(response.body);
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    var url = urlApi + "/register";

    final response =
        await network.postRequestWithoutToken(url, request.toJson());

    return registerResponseFromJson(response.body);
  }

  Future<PasswordResponse> password(PasswordRequest request) async {
    var url = urlApi + "/forgot-password";

    final response =
        await network.postRequestWithoutToken(url, request.toJson());

    return passwordResponseFromJson(response.body);
  }

  Future<bool> setIsLogin(bool sudahlogin) async {
    return await Cache.setCacheBool(key: isLogin, data: sudahlogin);
  }

  Future<bool> setToken(String token) async {
    return await Cache.setCache(key: accessToken, data: token);
  }

  Future<bool> cekIsLogin() async {
    return await Cache.getCacheBool(key: isLogin) ??
        Cache.getCache(key: isLogin);
  }

  Future<String> getAccessToken() async {
    return await Cache.getCache(key: accessToken);
  }

  Future<bool> setMerchant(String id) async {
    return await Cache.setCache(key: merchantId, data: id);
  }

  Future<String> getMerchantId() async {
    return await Cache.getCache(key: merchantId);
  }
}
