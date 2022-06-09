class CheckinRequest {
  String? user;
  String? member;
  String? merchant;

  CheckinRequest({this.user, this.member, this.merchant});

  Map<String, dynamic> toJson() =>
      {"user": user, "member": member, "merchant": merchant};
}
