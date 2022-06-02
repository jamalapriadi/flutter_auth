import 'dart:convert';

class PasswordResponse {
  bool? success;
  String? message;

  PasswordResponse({this.success, this.message});

  factory PasswordResponse.fromJson(Map<String, dynamic> json) =>
      PasswordResponse(
          success: json["success"] ?? false, message: json["message"]);
}

PasswordResponse passwordResponseFromJson(String str) =>
    PasswordResponse.fromJson(json.decode(str));
