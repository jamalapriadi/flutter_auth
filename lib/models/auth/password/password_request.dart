class PasswordRequest {
  String? current;
  String? password;
  String? passwordConfirmation;

  PasswordRequest({this.current, this.password, this.passwordConfirmation});

  Map<String, dynamic> toJson() => {
        "current": current,
        "password": password,
        "password_confirmation": passwordConfirmation
      };
}
