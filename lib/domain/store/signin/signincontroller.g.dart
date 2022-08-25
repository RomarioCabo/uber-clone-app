// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signincontroller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignInController on SignInControllerBase, Store {
  late final _$stateSaveUserAtom =
      Atom(name: 'SignInControllerBase.stateSaveUser', context: context);

  @override
  RequestState get stateSaveUser {
    _$stateSaveUserAtom.reportRead();
    return super.stateSaveUser;
  }

  @override
  set stateSaveUser(RequestState value) {
    _$stateSaveUserAtom.reportWrite(value, super.stateSaveUser, () {
      super.stateSaveUser = value;
    });
  }

  late final _$userAtom =
      Atom(name: 'SignInControllerBase.user', context: context);

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

  late final _$tipoUsuarioPassageiroAtom = Atom(
      name: 'SignInControllerBase.tipoUsuarioPassageiro', context: context);

  @override
  bool get tipoUsuarioPassageiro {
    _$tipoUsuarioPassageiroAtom.reportRead();
    return super.tipoUsuarioPassageiro;
  }

  @override
  set tipoUsuarioPassageiro(bool value) {
    _$tipoUsuarioPassageiroAtom.reportWrite(value, super.tipoUsuarioPassageiro,
        () {
      super.tipoUsuarioPassageiro = value;
    });
  }

  late final _$saveUserAsyncAction =
      AsyncAction('SignInControllerBase.saveUser', context: context);

  @override
  Future<void> saveUser(String name, String lastName, String email,
      String password, bool isPassenger) {
    return _$saveUserAsyncAction.run(
        () => super.saveUser(name, lastName, email, password, isPassenger));
  }

  @override
  String toString() {
    return '''
stateSaveUser: ${stateSaveUser},
user: ${user},
tipoUsuarioPassageiro: ${tipoUsuarioPassageiro}
    ''';
  }
}
