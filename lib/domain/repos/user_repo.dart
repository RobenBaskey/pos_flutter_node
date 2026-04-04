import 'package:pos/domain/entities/user_entity.dart';

abstract class UserRepo {
  Future<bool> setToken(String token);
  Future<bool> setUserData(UserEntity user);
}
