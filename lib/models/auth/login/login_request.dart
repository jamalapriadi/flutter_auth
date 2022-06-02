class LoginRequest {
  String? username;
  String? password;
  String? source;

  LoginRequest({this.username, this.password, this.source});

  copyWith({username, password}) => LoginRequest(
      username: username ?? this.username,
      password: password ?? this.password,
      source: source);

  Map<String, dynamic> toJson() =>
      {"username": username, "password": password, "source": source};
}
