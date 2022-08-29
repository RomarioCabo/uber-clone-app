import 'dart:convert';

class UserModel {
  int? id;
  String? name;
  String? lastName;
  String? email;
  String? password;
  String? typeUser;

  UserModel({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.password,
    this.typeUser,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json.containsKey('id') && json['id'] != null ? json['id'] : null;
    name =
        json.containsKey('name') && json['name'] != null ? json['name'] : null;
    lastName = json.containsKey('lastName') && json['lastName'] != null
        ? json['lastName']
        : null;
    email = json.containsKey('email') && json['email'] != null
        ? json['email']
        : null;
    password = json.containsKey('password') && json['password'] != null
        ? json['password']
        : null;
    typeUser = json.containsKey('typeUser') && json['typeUser'] != null
        ? json['typeUser']
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['typeUser'] = typeUser;
    return data;
  }

  String model2Json() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['typeUser'] = typeUser;
    return jsonEncode(data);
  }
}
