abstract class SignInController {
  Future<void> saveUser({
    required String name,
    required String lastName,
    required String email,
    required String password,
    required bool isPassenger,
  });
}
