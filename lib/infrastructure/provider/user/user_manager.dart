import 'package:flutter/foundation.dart';
import 'package:uber_clone/domain/user/authenticate_user_model.dart';
import 'package:uber_clone/domain/user/user_model.dart';
import 'package:uber_clone/infrastructure/helpers/api_base_helper.dart';

import '../../util/strings.dart';

class UserManager {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<UserModel> authenticateUser(
      {required AuthenticateUserModel credentials}) async {
    var data = credentials.toJson();

    if (kDebugMode) {
      print(data);
    }

    final response = await _helper.post(
      url: "$baseUrl/user/authenticate",
      body: data,
    );

    return UserModel.fromJson(response);
  }

  Future<UserModel> saveUser({required UserModel userModel}) async {
    var data = userModel.toJson();

    if (kDebugMode) {
      print(data);
    }

    final response = await _helper.post(
      url: "$baseUrl/user/create",
      body: data,
    );

    return UserModel.fromJson(response);
  }
}
