import 'package:uber_clone/domain/user/authenticateusermodel.dart';

import 'package:uber_clone/domain/user/user.dart';
import 'package:uber_clone/infrastructure/provider/user/usermanager.dart';

import '../../../domain/provider/userprovider.dart';

class UserProviderImpl implements UserProvider {
  final UserManager _manager = UserManager();

  @override
  Future<UserModel> authenticateUser(AuthenticateUserModel credentials) async {
    return await _manager.authenticateUser(credentials);
  }

  @override
  Future<UserModel> saveUser(UserModel userModel) async {
    return await _manager.saveUser(userModel);
  }
}
