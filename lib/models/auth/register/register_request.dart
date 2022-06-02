class RegisterRequest {
  String? fullname;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirmation;

  RegisterRequest(
      {this.fullname,
      this.email,
      this.phone,
      this.password,
      this.passwordConfirmation});

  copyWith({fullname, email, phone, password, passwordConfirmation}) =>
      RegisterRequest(
          fullname: fullname ?? this.fullname,
          email: email ?? this.email,
          phone: phone ?? this.phone,
          password: password ?? this.password,
          passwordConfirmation:
              passwordConfirmation ?? this.passwordConfirmation);

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": passwordConfirmation
      };
}
