class ScanMemberRequest {
  String? id;
  String? user;
  String? member;
  String? merchant;

  ScanMemberRequest({this.id, this.user, this.member, this.merchant});

  Map<String, dynamic> toJson() =>
      {"id": id, "user": user, "member": member, "merchant": merchant};
}
