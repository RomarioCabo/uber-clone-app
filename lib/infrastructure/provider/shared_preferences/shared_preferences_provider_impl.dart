import 'package:uber_clone/domain/user/user_model.dart';
import 'package:uber_clone/infrastructure/provider/shared_preferences/shared_preferences_manager.dart';

import '../../../domain/provider/shared_preferences_provider.dart';

class SharedPreferencesProviderImpl implements SharedPreferencesProvider {
  final SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager();

  @override
  saveUser({required UserModel user}) {
    sharedPreferencesManager.saveUser(user: user);
  }

  @override
  UserModel getUser() {
    return sharedPreferencesManager.getUser();
  }
}
