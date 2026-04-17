import 'package:pos/core/network/api_url.dart';
import 'package:pos/core/network/dio_client.dart';
import 'package:pos/data/model/user_model.dart';

abstract class ProviderDbSource {
  Future<DataPaginationModel<UserModel>> getUsers({
    required String type,
    int page = 1,
    int limit = 10,
  });
}

class ProviderDbSourceImpl implements ProviderDbSource {
  final DioClients _clients;
  ProviderDbSourceImpl(this._clients);

  @override
  Future<DataPaginationModel<UserModel>> getUsers({
    required String type,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      var response = await _clients.get(
        url: ApiUrl.getUserUrl(type: type, page: page, limit: limit),
      );

      return DataPaginationModel<UserModel>.fromJson(
        response["data"],
        (json) => UserModel.fromJson(json),
      );
    } on Exception catch (e) {
      rethrow;
    }
  }
}
