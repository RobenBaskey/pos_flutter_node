import 'package:pos/data/datasource/remote_db/provider_db_source.dart';
import 'package:pos/domain/repos/provider_repo.dart';

import '../model/user_model.dart';

class ProviderRepoIml extends ProviderRepo {
  final ProviderDbSource _providerDbSource;
  ProviderRepoIml(this._providerDbSource);

  @override
  Future<DataPaginationModel<UserModel>> getUsers({
    required String type,
    int page = 1,
    int limit = 10,
  }) {
    return _providerDbSource.getUsers(type: type, page: page, limit: limit);
  }
}
