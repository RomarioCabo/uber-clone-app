import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../infrastructure/helpers/request_state.dart';
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

  bool _locationPermissionIsGranted = false;

  final UserProviderImpl _provider = UserProviderImpl();

  final SharedPreferencesProvider _sharedPreferencesProvider =
      SharedPreferencesProviderImpl();

  @action
  @override
  Future<void> authenticate(String email, String password) async {
    try {
      if (kDebugMode) {
        print("locationPermissionIsGranted: $_locationPermissionIsGranted");
      }

      if(_locationPermissionIsGranted) {
        stateAuthenticate = Loading();
        await Future.delayed(const Duration(seconds: 1));

        user = await _provider.authenticateUser(AuthenticateUserModel(
          email: email,
          password: password,
        ));

        _sharedPreferencesProvider.saveUser(user);

        stateAuthenticate = Completed();
      } else {
        await Permission.location.request();
        requestLocationPermission();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      stateAuthenticate = Error(
        error: e.toString(),
      );
    }
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;

    if (kDebugMode) {
      print("requestLocationPermission => locationPermissionIsGranted: $status");
    }

    if (status.isGranted) {
      _locationPermissionIsGranted = true;
    }

    if (status.isDenied) {
      _locationPermissionIsGranted = false;
    }

    if (status.isPermanentlyDenied) {
      stateAuthenticate = Error(
        error: "Você dave liberar o acesso a sua loalização! No momento está permanentimente negeada!",
      );
    }
  }
}
