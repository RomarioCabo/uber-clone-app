import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../../../infrastructure/helpers/requeststate.dart';
import '../../../infrastructure/provider/user/userproviderimpl.dart';
import '../../user/authenticateusermodel.dart';
import '../../user/user.dart';

part 'logincontroller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  @observable
  RequestState stateAuthenticate = Initial();

  @observable
  UserModel user = UserModel();

  final UserProviderImpl _provider = UserProviderImpl();

  @action
  Future<void> authenticate(String email, String password) async {
    try {
      stateAuthenticate = Loading();
      await Future.delayed(const Duration(seconds: 1));

      user = await _provider.authenticateUser(AuthenticateUserModel(
        email: email,
        password: password,
      ));

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
