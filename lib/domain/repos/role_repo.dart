import '../entities/role_entity.dart';

abstract class RoleRepo {
  Future<List<AdministratorEntity>> getAllRoles();
  Future<void> addRole(AdministratorEntity role, String password);
  Future<void> deleteRole(String id);
}
