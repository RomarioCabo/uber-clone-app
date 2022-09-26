abstract class LoginController {
  Future<void> authenticate({required String email, required String password});
}