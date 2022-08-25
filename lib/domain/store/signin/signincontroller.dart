import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../../../infrastructure/helpers/requeststate.dart';
import '../../../infrastructure/provider/user/userproviderimpl.dart';
import '../../user/user.dart';

part 'signincontroller.g.dart';

class SignInController = SignInControllerBase with _$SignInController;

abstract class SignInControllerBase with Store {
  @observable
  RequestState stateSaveUser = Initial();

  @observable
  UserModel user = UserModel();

  @observable
  bool tipoUsuarioPassageiro = false;

  final UserProviderImpl _provider = UserProviderImpl();

  @action
  Future<void> saveUser(
    String name,
    String lastName,
    String email,
    String password,
    bool isPassenger,
  ) async {
    try {
      stateSaveUser = Loading();
      await Future.delayed(const Duration(seconds: 1));

      user = await _provider.saveUser(UserModel(
        id: null,
        name: name,
        lastName: lastName,
        email: email,
        password: password,
        typeUser: _buildTypeUser(isPassenger),
      ));

      stateSaveUser = Completed();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      stateSaveUser = Error(
        error: e.toString(),
      );
    }
  }

  String _buildTypeUser(bool isDriver) {
    if(isDriver) {
      return "DRIVER";
    }

    return "PASSENGER";
  }
}
