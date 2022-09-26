import 'package:uber_clone/domain/user/authenticate_user_model.dart';
import 'package:uber_clone/domain/user/user_model.dart';

abstract class UserProvider {
  Future<UserModel> authenticateUser({
    required AuthenticateUserModel credentials,
  });

  Future<UserModel> saveUser({
    required UserModel userModel,
  });
}
