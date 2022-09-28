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
  Future<void> saveUser({
    required String name,
    required String lastName,
    required String email,
    required String password,
    required bool isPassenger,
  }) async {
    try {
      if (_validateFields(
        name: name,
        lastName: lastName,
        email: email,
        password: password,
      )) {
        return;
      }

      stateSaveUser = Loading();
      await Future.delayed(const Duration(seconds: 1));

      user = await _provider.saveUser(
        userModel: UserModel(
          id: null,
          name: name,
          lastName: lastName,
          email: email,
          password: password,
          typeUser: _buildTypeUser(isDriver: isPassenger),
        ),
      );

      stateSaveUser = Completed();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(stackTrace);
      }

      stateSaveUser = Error(
        error: e.toString(),
      );
    }
  }

  String _buildTypeUser({required bool isDriver}) {
    if (isDriver) {
      return "DRIVER";
    }

    return "PASSENGER";
  }

  bool _validateFields({
    required String name,
    required String lastName,
    required String email,
    required String password,
  }) {
    if (name.isEmpty && lastName.isEmpty && email.isEmpty && password.isEmpty) {
      stateSaveUser = Error(
        error: "Preecha os campos!",
      );

      return false;
    }

    if (name.isEmpty) {
      stateSaveUser = Error(
        error: "Preecha o campo nome.",
      );

      return false;
    }

    if (lastName.isEmpty) {
      stateSaveUser = Error(
        error: "Preecha o campo sobrenome.",
      );

      return false;
    }

    if (email.isEmpty) {
      stateSaveUser = Error(
        error: "Preecha o campo email.",
      );

      return false;
    }

    if (password.isEmpty) {
      stateSaveUser = Error(
        error: "Preecha o campo senha.",
      );

      return false;
    }

    return false;
  }
}
