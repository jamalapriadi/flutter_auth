import 'dart:convert';

class Checkin {
  String? id;
  String? petugasId;
  String? userId;
  String? memberId;
  String? merchantId;
  String? tanggal;
  String? jam;
  String? fullJam;
  Object? namaMember;

  Checkin({
    this.id,
    this.petugasId,
    this.userId,
    this.memberId,
    this.merchantId,
    this.tanggal,
    this.jam,
    this.fullJam,
    this.namaMember,
  });

  factory Checkin.fromJson(Map<String, dynamic> json) => Checkin(
      id: json["data"]["id"],
      petugasId: json["data"]["petugas_id"],
      userId: json["data"]["userId"],
      memberId: json["data"]["member_id"],
      merchantId: json["data"]["merchant_id"],
      tanggal: json["data"]["tanggal"],
      jam: json["data"]["jam"],
      fullJam: json["data"]["full_jam"],
      namaMember: "");

  factory Checkin.fromSingleJson(Map<String, dynamic> json) => Checkin(
      id: json["id"],
      petugasId: json["petugas_id"],
      userId: json["userId"],
      memberId: json["member_id"],
      merchantId: json["merchant_id"],
      tanggal: json["tanggal"],
      jam: json["jam"],
      fullJam: json["full_jam"],
      namaMember:
          json["member"] == null ? '' : json["member"]["data"]["full_name"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "petugas_id": petugasId,
        "user_id": userId,
        "member_id": memberId,
        "merchant_id": merchantId,
        "tanggal": tanggal,
        "jam": jam,
        "full_jam": fullJam
      };
}

Checkin checkinFromJson(String str) => Checkin.fromJson(json.decode(str));

List<Checkin> checkinFromList(String str) {
  final data = json.decode(str);

  return List<Checkin>.from(
      data["data"].map((item) => Checkin.fromSingleJson(item)));
}
