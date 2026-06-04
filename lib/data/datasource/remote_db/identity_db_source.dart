import 'package:pos/core/network/api_url.dart';
import 'package:pos/core/network/dio_client.dart';

import '../../model/identity_model.dart';

abstract class IdentityDbSource {
  Future<List<IdentityModel>> getIdentity({String? status});
  Future<void> verifyIdentity(String id, String status);
}

class IdentityDbSourceImpl implements IdentityDbSource {
  final DioClients _clients;
  IdentityDbSourceImpl(this._clients);

  @override
  Future<List<IdentityModel>> getIdentity({String? status}) async {
    try {
      final response = await _clients.get(
        url: ApiUrl.getIdentityUrl(status: status),
        isTokenRequired: true,
      );

      if (response["data"] != null && response["data"]["identities"] != null) {
        return List<IdentityModel>.from(
          response["data"]["identities"]!.map((x) => IdentityModel.fromJson(x)),
        );
      }
      return [];
    } catch (e) {
      throw Exception('Error fetching identity data: $e');
    }
  }

  @override
  Future<void> verifyIdentity(String id, String status) async {
    try {
      await _clients.post(
        url: ApiUrl.verifyIdentityUrl(id),
        isTokenRequired: true,
        body: {"status": status},
      );
    } catch (e) {
      throw Exception('Error verifying identity: $e');
    }
  }
}
