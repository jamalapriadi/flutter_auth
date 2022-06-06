import 'dart:convert';

class MeResponse {
  String? id;
  String? name;
  String? email;
  String? active;
  String? profilePicture;
  String? profilePictureUrl;

  MeResponse(
      {this.id,
      this.name,
      this.email,
      this.active,
      this.profilePicture,
      this.profilePictureUrl});

  factory MeResponse.fromJson(Map<String, dynamic> json) => MeResponse(
      id: json["data"]["id"] ?? '',
      name: json["data"]["name"] ?? '',
      email: json["data"]["email"] ?? '',
      active: json["data"]["active"] ?? '',
      profilePicture: json["data"]["profile_picture"] ?? '',
      profilePictureUrl: json["data"]["profile_picture_url"] ?? '');

  factory MeResponse.fromJsonList(Map<String, dynamic> json) => MeResponse(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      active: json["active"] ?? '',
      profilePicture: json["profile_picture"] ?? '',
      profilePictureUrl: json["profile_picture_url"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "active": active,
        "profile_picture": profilePicture,
        "profile_picture_url": profilePictureUrl
      };
}

MeResponse meResponseFromJson(String str) =>
    MeResponse.fromJson(json.decode(str));

MeResponse meResponseFromJsonList(String str) =>
    MeResponse.fromJsonList(json.decode(str));
