import 'package:uber_clone/domain/user/authenticate_user_model.dart';
import 'package:uber_clone/domain/user/user.dart';

abstract class UserProvider {
  Future<UserModel> authenticateUser(
    AuthenticateUserModel credentials,
  );

  Future<UserModel> saveUser(
    UserModel userModel,
  );
}
