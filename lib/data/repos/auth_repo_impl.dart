import 'package:pos/data/model/auth_model.dart';
import 'package:pos/domain/repos/auth_repo.dart';

import '../datasource/remote_db/auth_db_source.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthDbSource _authRemoteDB;
  AuthRepoImpl(this._authRemoteDB);

  @override
  Future<AuthModel?> login(String phone, String password) async {
    return _authRemoteDB.login(phone, password);
  }
}
