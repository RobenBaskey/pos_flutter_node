abstract class AuthRepo {
  Future<String?> login(String phone, String password);
}
