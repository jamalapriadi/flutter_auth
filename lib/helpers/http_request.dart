import 'dart:async';
import 'dart:io';

import 'package:hsp_gate/helpers/cache_storage.dart';
import 'package:http/http.dart' show Client;

import 'cache_const.dart';

class Network {
  Client client = Client();

  static const String accept = 'application/json';
  static const String contentType = 'application/x-www-form-urlencoded';

  Future<dynamic> getRequest(String url, {bool withToken = true}) async {
    try {
      final accessTokenL = await Cache.getCache(key: accessToken);

      final response = await client.get(Uri.parse(url), headers: {
        'content-type': contentType,
        'accept': accept,
        HttpHeaders.authorizationHeader: 'Bearer $accessTokenL'
      }).timeout(const Duration(seconds: 20));

      return response;
    } on TimeoutException catch (_) {
      throw Exception();
    }
  }

  Future<dynamic> putRequest(String url, dynamic body) async {
    final accessTokenL = await Cache.getCache(key: accessToken);

    final response = await client.put(Uri.parse(url),
        headers: {
          'content-type': contentType,
          'accept': accept,
          HttpHeaders.authorizationHeader: 'Bearer $accessTokenL'
        },
        body: body);

    if (response.statusCode == 401) {
      throw Exception('${response.statusCode}');
    }

    return response;
  }

  //jika post request menggunakan data
  Future<dynamic> postRequestForm(String url, Map<String, dynamic> body) async {
    final accessTokenL = await Cache.getCache(key: accessToken);
    final response = await client.post(
      Uri.parse(url),
      headers: {
        'Accept': accept,
        HttpHeaders.authorizationHeader: 'Bearer $accessTokenL'
      },
      body: body,
    );

    if (response.statusCode == 401) {
      throw Exception('${response.statusCode}');
    }

    return response;
  }

  //jika post tidak ada datanya
  Future<dynamic> postRequest(String url) async {
    final accessTokenL = await Cache.getCache(key: accessToken);
    final response = await client.post(
      Uri.parse(url),
      headers: {
        'Accept': accept,
        HttpHeaders.authorizationHeader: 'Bearer $accessTokenL'
      },
    );

    if (response.statusCode == 401) {
      throw Exception('${response.statusCode}');
    }

    return response;
  }

  Future<dynamic> deleteRequest(String url) async {
    final accessTokenL = await Cache.getCache(key: accessToken);

    final response = await client.delete(Uri.parse(url), headers: {
      'content-type': contentType,
      'accept': accept,
      HttpHeaders.authorizationHeader: 'Bearer $accessTokenL'
    });

    if (response.statusCode == 401) {
      throw Exception('${response.statusCode}');
    }

    return response;
  }

  Future<dynamic> postRequestWithoutToken(String url, dynamic body) async {
    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': contentType,
          'Accept': accept,
        },
        body: body,
      );
      return response;
    } on TimeoutException catch (_) {
      throw Exception(_);
    }
  }

  Future<dynamic> postRequestRefreshToken(String url) async {
    final accessTokenL = await Cache.getCache(key: accessToken);
    final response = await client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': contentType,
        'Accept': accept,
        HttpHeaders.authorizationHeader: 'Bearer $accessTokenL'
      },
    );

    if (response.statusCode == 401) {
      throw Exception('${response.statusCode}');
    }

    return response;
  }
}
