import 'dart:convert';

class MerchantResponse {
  String? id;
  String? nama;
  String? alamat;

  MerchantResponse({this.id, this.nama, this.alamat});

  factory MerchantResponse.fromJson(Map<String, dynamic> json) =>
      MerchantResponse(
          id: json["id"], nama: json["nama"], alamat: json["alamat"]);

  Map<String, dynamic> toJson() => {"id": id, "nama": nama, "alamat": alamat};
}

List<MerchantResponse> merchantResponseFromJson(String str) {
  final data = json.decode(str);

  return List<MerchantResponse>.from(
      data["data"].map((item) => MerchantResponse.fromJson(item)));
}

MerchantResponse singleMerchantResponseFromJson(String str) {
  final data = json.decode(str);

  return MerchantResponse.fromJson(data["data"]);
}

MerchantResponse singleListMerchantResponseFromJson(String str) {
  final data = json.decode(str);

  return MerchantResponse.fromJson(data);
}
