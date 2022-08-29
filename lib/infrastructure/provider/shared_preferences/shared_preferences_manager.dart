import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/user/user_model.dart';

class SharedPreferencesManager {
  late SharedPreferences prefs;
  late Future _doneFuture;

  Future get initializationDone => _doneFuture;

  SharedPreferencesManager() {
    _doneFuture = _initDB();
  }

  _initDB() async {
    prefs = await SharedPreferences.getInstance();
  }

  void saveUser(UserModel user) {
      prefs.setString("user_model", user.model2Json());
  }

  UserModel getUser() {
    String user = prefs.get("user_model").toString();
    return UserModel.fromJson(jsonDecode(user));
  }
}