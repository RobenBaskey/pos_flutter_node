import 'package:pos/data/datasource/remote_db/role_db.dart';
import 'package:pos/domain/entities/role_entity.dart';

import '../../domain/repos/role_repo.dart';
import '../model/role_model.dart';

class RoleRepoImpl extends RoleRepo {
  final RoleDb _roleDb;
  RoleRepoImpl(this._roleDb);

  @override
  Future<List<AdministratorEntity>> getAllRoles() async {
    var result = await _roleDb.getAllRoles();
    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> addRole(AdministratorEntity role, String password) async {
    await _roleDb.addRole(AdministratorModel.fromEntity(role), password);
  }

  @override
  Future<void> deleteRole(String id) async {
    await _roleDb.deleteRole(id);
  }
}
