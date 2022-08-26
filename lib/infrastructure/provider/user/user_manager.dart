import 'package:flutter/foundation.dart';
import 'package:uber_clone/domain/user/authenticate_user_model.dart';
import 'package:uber_clone/domain/user/user.dart';
import 'package:uber_clone/infrastructure/helpers/api_base_helper.dart';

import '../../util/strings.dart';

class UserManager {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<UserModel> authenticateUser(AuthenticateUserModel credentials) async {
    String json = credentials.model2Json();

    if (kDebugMode) {
      print(json);
    }

    final response = await _helper.post(
      url: "$baseUrl/user/authenticate",
      body: json,
    );

    return UserModel.fromJson(response);
  }

  Future<UserModel> saveUser(UserModel userModel) async {
    String json = userModel.model2Json();

    if (kDebugMode) {
      print(json);
    }

    final response = await _helper.post(
      url: "$baseUrl/user/create",
      body: json,
    );

    return UserModel.fromJson(response);
  }
}
