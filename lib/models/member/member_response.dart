import 'dart:convert';

class MemberResponse {
  String? id;
  String? type;
  String? memberId;
  String? title;
  String? firstName;
  String? lastName;
  String? fullName;
  String? status;
  int? vipLevel;
  String? registrationDate;
  String? renewalDate;
  String? validUntil;
  String? address;
  String? phone;
  String? fax;
  String? contact;
  String? email;
  String? birthday;
  String? active;
  String? photo;
  String? photoUrl;
  String? userId;
  String? tanggal;
  String? jam;

  MemberResponse(
      {this.id,
      this.type,
      this.memberId,
      this.title,
      this.firstName,
      this.lastName,
      this.fullName,
      this.status,
      this.vipLevel,
      this.registrationDate,
      this.renewalDate,
      this.validUntil,
      this.address,
      this.phone,
      this.fax,
      this.contact,
      this.email,
      this.birthday,
      this.active,
      this.photo,
      this.photoUrl,
      this.userId,
      this.tanggal,
      this.jam});

  factory MemberResponse.fromJson(Map<String, dynamic> json) => MemberResponse(
      id: json["data"]["id"] ?? "",
      type: json["data"]["type"] ?? "",
      memberId: json["data"]["member_id"] ?? "",
      title: json["data"]["title"] ?? "",
      firstName: json["data"]["first_name"] ?? "",
      lastName: json["data"]["last_name"] ?? "",
      fullName: json["data"]["full_name"] ?? "",
      status: json["data"]["status"] ?? "",
      vipLevel: json["data"]["vip_level"] ?? 0,
      registrationDate: json["data"]["registration_date"] ?? "",
      renewalDate: json["data"]["renewal_date"] ?? "",
      validUntil: json["data"]["valid_until"] ?? "",
      address: json["data"]["address"] ?? "",
      phone: json["data"]["phone"] ?? "",
      fax: json["data"]["fax"] ?? "",
      contact: json["data"]["contact"] ?? "",
      email: json["data"]["email"] ?? "",
      birthday: json["data"]["birthday"] ?? "",
      active: json["data"]["active"] ?? "",
      photo: json["data"]["photo"] ?? "",
      photoUrl: json["data"]["photo_url"] ?? "",
      userId: json["data"]["user_id"] ?? "",
      tanggal: json["data"]["tanggal"] ?? "",
      jam: json["data"]["jam"] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "member_id": memberId,
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "full_name": fullName,
        "status": status,
        "vip_level": vipLevel,
        "registration_date": registrationDate,
        "renewal_date": renewalDate,
        "valid_until": validUntil,
        "address": address,
        "phone": phone,
        "fax": fax,
        "contact": contact,
        "email": email,
        "birthday": birthday,
        "active": active,
        "photo": phone,
        "photo_url": photoUrl,
        "user_id": userId,
        "tanggal": tanggal,
        "jam": jam
      };
}

MemberResponse memberResponseFromJson(String str) =>
    MemberResponse.fromJson(json.decode(str));
