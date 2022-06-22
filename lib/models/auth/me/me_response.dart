import 'dart:convert';

class MeResponse {
  bool? succes;
  String? id;
  String? name;
  String? email;
  String? active;
  String? profilePicture;
  String? profilePictureUrl;

  MeResponse({
    this.succes,
    this.id,
    this.name,
    this.email,
    this.active,
    this.profilePicture,
    this.profilePictureUrl,
  });

  factory MeResponse.fromSuccessJson(Map<String, dynamic> js) => MeResponse(
        succes: true,
        id: js["data"]["id"] ?? '',
        name: js["data"]["name"] ?? '',
        email: js["data"]["email"] ?? '',
        active: js["data"]["active"] ?? '',
        profilePicture: js["data"]["profile_picture"] ?? '',
        profilePictureUrl: js["data"]["profile_picture_url"] ?? '',
      );

  factory MeResponse.fromFailedJson(Map<String, dynamic> json) => MeResponse(
      succes: false,
      id: '',
      name: '',
      email: '',
      active: '',
      profilePicture: '',
      profilePictureUrl: '');

  factory MeResponse.fromJsonList(Map<String, dynamic> json) => MeResponse(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        active: json["active"] ?? '',
        profilePicture: json["profile_picture"] ?? '',
        profilePictureUrl: json["profile_picture_url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "active": active,
        "profile_picture": profilePicture,
        "profile_picture_url": profilePictureUrl,
      };
}

MeResponse meResponseSuccessFromJson(String str) =>
    MeResponse.fromSuccessJson(json.decode(str));

MeResponse meResponseFailedFromJson(String str) =>
    MeResponse.fromFailedJson(json.decode(str));

MeResponse meResponseFromJsonList(String str) =>
    MeResponse.fromJsonList(json.decode(str));
