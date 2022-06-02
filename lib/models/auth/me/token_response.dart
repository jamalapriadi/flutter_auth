import 'dart:convert';

class TokenResponse {
  String? token;

  TokenResponse({this.token});

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      TokenResponse(token: json["token"]);

  Map<String, dynamic> toJson() => {"token": token};
}

TokenResponse tokenResponse(String str) =>
    TokenResponse.fromJson(json.decode(str));
