import 'package:pos/core/network/api_url.dart';
import 'package:pos/core/network/dio_client.dart';

abstract class AuthDbSource {
  Future<String?> login(String phone, String password);
}

class AuthDbSourceImpl extends AuthDbSource {
  final DioClients _clients;
  AuthDbSourceImpl(this._clients);

  @override
  Future<String?> login(String phone, String password) async {
    try {
      final response = await _clients.post(
        url: ApiUrl.loginUrl(),
        body: {"phone": phone, "password": password},
      );
      return response['token'];
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    }
  }
}
