import 'dart:convert';

class LoginResponse {
  bool? success;
  String? message;
  String? accessToken;
  String? tokenType;

  LoginResponse({this.success, this.message, this.accessToken, this.tokenType});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      success: json["success"] ?? '',
      message: json["message"] ?? '',
      accessToken: json["access_token"] ?? '',
      tokenType: json["token_type"] ?? '');

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "access_token": accessToken,
        "token_type": tokenType
      };
}

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));
