class UpdateProfileRequest {
  String? name;
  String? email;

  UpdateProfileRequest({this.name, this.email});

  Map<String, dynamic> toJson() => {"name": name, "email": email};
}
