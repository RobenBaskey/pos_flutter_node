import 'package:pos/data/datasource/local_db/user_db_service.dart';
import 'package:pos/domain/entities/user_entity.dart';
import 'package:pos/domain/repos/user_repo.dart';

class UserRepoImpl extends UserRepo {
  final UserDbService _userLocalDB;
  UserRepoImpl(this._userLocalDB);

  @override
  Future<bool> setToken(String token) {
    return _userLocalDB.setToken(token);
  }

  @override
  Future<bool> setUserData(UserEntity user) {
    return _userLocalDB.setUserData(user.toModel());
  }
}
