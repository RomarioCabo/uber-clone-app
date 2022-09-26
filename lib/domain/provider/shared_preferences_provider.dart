import 'package:uber_clone/domain/user/user_model.dart';

abstract class SharedPreferencesProvider {
  saveUser({required UserModel user});

  UserModel getUser();
}