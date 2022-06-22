import 'dart:convert';

class ScanMemberResponse {
  bool? success;
  String? message;

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

  ScanMemberResponse(
      {this.success,
      this.message,
      this.id,
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

  factory ScanMemberResponse.fromJson(Map<String, dynamic> json) =>
      ScanMemberResponse(
          success: json["success"],
          message: json["message"],
          id: json["member"] == null ? "" : json["member"]["data"]["id"],
          type: json["member"] == null ? "" : json["member"]["data"]["type"],
          memberId:
              json["member"] == null ? "" : json["member"]["data"]["member_id"],
          title: json["member"] == null ? "" : json["member"]["data"]["title"],
          firstName: json["member"] == null
              ? ""
              : json["member"]["data"]["first_name"],
          lastName:
              json["member"] == null ? "" : json["member"]["data"]["last_name"],
          fullName:
              json["member"] == null ? "" : json["member"]["data"]["full_name"],
          status:
              json["member"] == null ? "" : json["member"]["data"]["status"],
          vipLevel:
              json["member"] == null ? 0 : json["member"]["data"]["vip_level"],
          registrationDate: json["member"] == null
              ? ""
              : json["member"]["data"]["registration_date"],
          renewalDate: json["member"] == null
              ? ""
              : json["member"]["data"]["renewal_date"],
          validUntil: json["member"] == null
              ? ""
              : json["member"]["data"]["valid_until"],
          address:
              json["member"] == null ? "" : json["member"]["data"]["address"],
          phone: json["member"] == null ? "" : json["member"]["data"]["phone"],
          fax: json["member"] == null ? "" : json["member"]["data"]["fax"],
          contact:
              json["member"] == null ? "" : json["member"]["data"]["contact"],
          email: json["member"] == null ? "" : json["member"]["data"]["email"],
          birthday:
              json["member"] == null ? "" : json["member"]["data"]["birthday"],
          active:
              json["member"] == null ? "" : json["member"]["data"]["active"],
          photo: json["member"] == null ? "" : json["member"]["data"]["photo"],
          photoUrl:
              json["member"] == null ? "" : json["member"]["data"]["photo_url"],
          userId:
              json["member"] == null ? "" : json["member"]["data"]["user_id"],
          tanggal:
              json["member"] == null ? "" : json["member"]["data"]["tanggal"],
          jam: json["member"] == null ? "" : json["member"]["data"]["jam"]);

  factory ScanMemberResponse.fromJsonFailed(Map<String, dynamic> json) =>
      ScanMemberResponse(success: json["success"], message: json["message"]);

  Map<String, dynamic> toJson() => {"success": success, "message": message};
}

ScanMemberResponse scanMemberResponse(String str) =>
    ScanMemberResponse.fromJson(json.decode(str));

ScanMemberResponse scanMemberResponseFailed(String str) =>
    ScanMemberResponse.fromJsonFailed(json.decode(str));
