import 'dart:convert';

class DefaultResponse {
  bool? success;
  String? message;

  DefaultResponse({this.success, this.message});

  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      DefaultResponse(success: json["success"], message: json["message"]);
}

DefaultResponse defaultResponseFromJson(String str) =>
    DefaultResponse.fromJson(json.decode(str));
