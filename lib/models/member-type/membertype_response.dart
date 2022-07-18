import 'dart:convert';

class MembertypeResponse {
  String? id;
  String? name;
  String? image;
  String? regulation;
  String? photoUrl;

  MembertypeResponse(
      {this.id, this.name, this.image, this.regulation, this.photoUrl});

  factory MembertypeResponse.fromJson(Map<String, dynamic> json) =>
      MembertypeResponse(
          id: json["id"],
          name: json["name"],
          image: json["image"],
          regulation: json["regulation"],
          photoUrl: json["photo_url"]);
}

List<MembertypeResponse> membertypeResponseFromjson(String str) {
  final data = json.decode(str);

  return List<MembertypeResponse>.from(
      data["data"].map((item) => MembertypeResponse.fromJson(item)));
}
