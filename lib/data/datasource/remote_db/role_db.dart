import 'package:pos/core/network/dio_client.dart';

import '../../../core/network/api_url.dart';
import '../../model/role_model.dart';

abstract class RoleDb {
  Future<List<AdministratorModel>> getAllRoles();
  Future<void> addRole(AdministratorModel role, String password);
  Future<void> deleteRole(String id);
}

class RoleDbImpl extends RoleDb {
  final DioClients _clients;
  RoleDbImpl(this._clients);

  @override
  Future<List<AdministratorModel>> getAllRoles() async {
    try {
      var response = await _clients.get(
        url: ApiUrl.getRoleUrl(),
        isTokenRequired: true,
      );
      return List<AdministratorModel>.from(
        response["data"]!.map((x) => AdministratorModel.fromJson(x)),
      );
    } catch (e) {
      throw Exception("Failed to load roles: ${e.toString()}");
    }
  }

  @override
  Future<void> addRole(AdministratorModel role, String password) async {
    try {
      await _clients.post(
        url: ApiUrl.addRoleUrl(),
        body: role.toJson()..addAll({"password": password}),
        isTokenRequired: true,
      );
    } catch (e) {
      throw Exception("Failed to add role: ${e.toString()}");
    }
  }

  @override
  Future<void> deleteRole(String id) async {
    try {
      await _clients.delete(
        url: ApiUrl.deleteRoleUrl(id),
        isTokenRequired: true,
      );
    } catch (e) {
      throw Exception("Failed to delete role: ${e.toString()}");
    }
  }
}
