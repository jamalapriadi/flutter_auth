import 'dart:convert';

class OtpResponse {
  bool? success;
  String? message;

  OtpResponse({this.success, this.message});

  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      OtpResponse(success: json["success"] ?? false, message: json["message"]);
}

OtpResponse otpResponseFromJson(String str) =>
    OtpResponse.fromJson(json.decode(str));
