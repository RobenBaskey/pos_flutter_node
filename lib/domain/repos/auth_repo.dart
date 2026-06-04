import '../../data/model/auth_model.dart';

abstract class AuthRepo {
  Future<AuthModel?> login(String phone, String password);
}
