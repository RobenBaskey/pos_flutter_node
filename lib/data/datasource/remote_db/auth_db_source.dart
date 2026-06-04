import 'package:pos/core/network/api_url.dart';
import 'package:pos/core/network/dio_client.dart';
import 'package:pos/data/model/auth_model.dart';

abstract class AuthDbSource {
  Future<AuthModel?> login(String phone, String password);
}

class AuthDbSourceImpl extends AuthDbSource {
  final DioClients _clients;
  AuthDbSourceImpl(this._clients);

  @override
  Future<AuthModel?> login(String phone, String password) async {
    try {
      final response = await _clients.post(
        url: ApiUrl.loginUrl(),
        body: {"phone": phone, "password": password},
      );
      return AuthModel.fromJson(response);
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    }
  }
}
