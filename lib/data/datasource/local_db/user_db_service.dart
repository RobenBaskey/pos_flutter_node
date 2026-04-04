import 'package:pos/core/constants/app_keys.dart';
import 'package:pos/data/datasource/local_db/shared_preference_service.dart';
import 'package:pos/data/model/user_model.dart';

abstract class UserDbService {
  Future<bool> setToken(String token);
  Future<bool> setUserData(UserModel user);
}

class UserDbServiceImpl extends UserDbService {
  final SharedPreferenceService _service;
  UserDbServiceImpl(this._service);

  @override
  Future<bool> setToken(String token) async {
    await _service.setString(AppKeys.tokenKey, token);
    return true;
  }

  @override
  Future<bool> setUserData(UserModel user) async {
    await _service.setString(AppKeys.userDataKey, user.toRawJson());
    return true;
  }
}
