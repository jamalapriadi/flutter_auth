class UpdatePasswordRequest {
  String? current;
  String? password;
  String? passwordConfirmation;

  UpdatePasswordRequest(
      {this.current, this.password, this.passwordConfirmation});

  Map<String, dynamic> toJson() => {
        "current": current,
        "password": password,
        "password_confirmation": passwordConfirmation
      };
}
