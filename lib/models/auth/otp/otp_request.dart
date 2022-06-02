class OtpRequest {
  String? email;
  String? otp;

  OtpRequest({this.email, this.otp});

  Map<String, dynamic> toJson() => {"email": email, "otp": otp};
}
