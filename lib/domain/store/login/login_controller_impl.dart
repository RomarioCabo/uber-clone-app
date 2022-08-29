import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../infrastructure/helpers/request_state.dart';
import '../../../infrastructure/provider/shared_preferences/shared_preferences_manager.dart';
import '../../../infrastructure/provider/shared_preferences/shared_preferences_provider_impl.dart';
import '../../../infrastructure/provider/user/user_provider_impl.dart';
import '../../provider/shared_preferences_provider.dart';
import '../../user/authenticate_user_model.dart';
import '../../user/user_model.dart';
import 'login_controller.dart';

part 'login_controller_impl.g.dart';

class LoginControllerImpl = LoginControllerBase with _$LoginControllerImpl;

abstract class LoginControllerBase with Store implements LoginController {
  @observable
  RequestState stateAuthenticate = Initial();

  @observable
  UserModel user = UserModel();

  final UserProviderImpl _provider = UserProviderImpl();

  final SharedPreferencesProvider _sharedPreferencesProvider =
      SharedPreferencesProviderImpl();

  @action
  @override
  Future<void> authenticate(String email, String password) async {
    try {
      stateAuthenticate = Loading();
      await Future.delayed(const Duration(seconds: 1));

      user = await _provider.authenticateUser(AuthenticateUserModel(
        email: email,
        password: password,
      ));

      _sharedPreferencesProvider.saveUser(user);

      stateAuthenticate = Completed();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      stateAuthenticate = Error(
        error: e.toString(),
      );
    }
  }
}
