import 'package:uber_clone/domain/user/user_model.dart';

abstract class SharedPreferencesProvider {
  saveUser(UserModel user);

  UserModel getUser();
}