import '../../domain/repos/identity_repo.dart';
import '../datasource/remote_db/identity_db_source.dart';
import '../model/identity_model.dart';

class IdentityRepoImpl implements IdentityRepo {
  final IdentityDbSource _dbSource;
  IdentityRepoImpl(this._dbSource);
  @override
  Future<List<IdentityModel>> getIdentity({String? status}) async {
    try {
      return await _dbSource.getIdentity(status: status);
    } catch (e) {
      throw Exception('Error fetching identity data: $e');
    }
  }

  @override
  Future<void> verifyIdentity(String id, String status) async {
    try {
      await _dbSource.verifyIdentity(id, status);
    } catch (e) {
      throw Exception('Error verifying identity: $e');
    }
  }
}
