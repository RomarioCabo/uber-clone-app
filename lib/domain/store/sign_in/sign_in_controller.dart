abstract class SignInController {
  Future<void> saveUser(String name, String lastName, String email,
      String password, bool isPassenger);
}
