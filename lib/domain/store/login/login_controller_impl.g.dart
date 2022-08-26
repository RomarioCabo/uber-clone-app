// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller_impl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginControllerImpl on LoginControllerBase, Store {
  late final _$stateAuthenticateAtom =
      Atom(name: 'LoginControllerBase.stateAuthenticate', context: context);

  @override
  RequestState get stateAuthenticate {
    _$stateAuthenticateAtom.reportRead();
    return super.stateAuthenticate;
  }

  @override
  set stateAuthenticate(RequestState value) {
    _$stateAuthenticateAtom.reportWrite(value, super.stateAuthenticate, () {
      super.stateAuthenticate = value;
    });
  }

  late final _$userAtom =
      Atom(name: 'LoginControllerBase.user', context: context);

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$authenticateAsyncAction =
      AsyncAction('LoginControllerBase.authenticate', context: context);

  @override
  Future<void> authenticate(String email, String password) {
    return _$authenticateAsyncAction
        .run(() => super.authenticate(email, password));
  }

  @override
  String toString() {
    return '''
stateAuthenticate: ${stateAuthenticate},
user: ${user}
    ''';
  }
}
