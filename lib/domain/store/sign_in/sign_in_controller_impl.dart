import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:uber_clone/domain/store/sign_in/sign_in_controller.dart';

import '../../../infrastructure/helpers/request_state.dart';
import '../../../infrastructure/provider/user/user_provider_impl.dart';
import '../../user/user_model.dart';

part 'sign_in_controller_impl.g.dart';

class SignInControllerImpl = SignInControllerBase with _$SignInControllerImpl;

abstract class SignInControllerBase with Store implements SignInController {
  @observable
  RequestState stateSaveUser = Initial();

  @observable
  UserModel user = UserModel();

  @observable
  bool tipoUsuarioPassageiro = false;

  final UserProviderImpl _provider = UserProviderImpl();

  @action
  @override
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
    if (isDriver) {
      return "DRIVER";
    }

    return "PASSENGER";
  }
}
