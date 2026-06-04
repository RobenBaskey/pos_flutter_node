import '../../data/model/identity_model.dart';

abstract class IdentityRepo {
  Future<List<IdentityModel>> getIdentity({String? status});
  Future<void> verifyIdentity(String id, String status);
}