import 'dart:convert';

class RegisterResponse {
  bool? success;
  String? message;
  String? email;

  RegisterResponse({this.success, this.message, this.email});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
          success: json["success"] ?? true,
          message: json["message"],
          email: json["email"]);
}

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));
