import '../../data/model/user_model.dart';

abstract class ProviderRepo {
  Future<DataPaginationModel<UserModel>> getUsers({
    required String type,
    int page = 1,
    int limit = 10,
  });
}
