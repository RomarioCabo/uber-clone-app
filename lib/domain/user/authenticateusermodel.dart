import 'dart:convert';

class AuthenticateUserModel {
  String? email;
  String? password;

  AuthenticateUserModel({
    this.email,
    this.password,
  });

  String model2Json() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return jsonEncode(data);
  }
}
