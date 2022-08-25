import 'package:uber_clone/domain/user/authenticateusermodel.dart';
import 'package:uber_clone/domain/user/user.dart';

abstract class UserProvider {
  Future<UserModel> authenticateUser(
    AuthenticateUserModel credentials,
  );

  Future<UserModel> saveUser(
    UserModel userModel,
  );
}
