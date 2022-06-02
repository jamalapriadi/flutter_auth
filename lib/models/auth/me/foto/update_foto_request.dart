class UpdateFotoRequest {
  String? image;

  UpdateFotoRequest({this.image});

  Map<String, dynamic> toJson() => {"image": image};
}
