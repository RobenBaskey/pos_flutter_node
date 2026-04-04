import '../../../core/network/api_url.dart';
import '../../../core/network/dio_client.dart';
import '../../model/job_type_model.dart';

abstract class WorkplaceTypeSource {
  Future<bool> addWorkplaceType({
    required String title,
    required String description,
  });
  Future<bool> updateWorkplaceType({
    required String id,
    required String title,
    String isActive = "1",
  });
  Future<bool> deleteWorkplaceType({required String id});
  Future<List<JobTypeModel>> getWorkplaceTypes();
}

class WorkplaceTypeSourceImpl extends WorkplaceTypeSource {
  final DioClients _clients;
  WorkplaceTypeSourceImpl(this._clients);

  @override
  Future<bool> addWorkplaceType({
    required String title,
    required String description,
  }) async {
    try {
      await _clients.post(
        url: ApiUrl.addWorkplaceTypeUrl(),
        body: {"title": title, "description": "demo"},
        isTokenRequired: true,
      );
      return true;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteWorkplaceType({required String id}) async {
    try {
      await _clients.delete(
        url: ApiUrl.deleteWorkplaceTypeUrl(id),
        isTokenRequired: true,
      );
      return true;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> updateWorkplaceType({
    required String id,
    required String title,
    String isActive = "1",
  }) async {
    try {
      await _clients.put(
        url: ApiUrl.updateWorkplaceTypeUrl(),
        body: {"id": id, "title": title, "is_active": isActive},
        isTokenRequired: true,
      );
      return true;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<JobTypeModel>> getWorkplaceTypes() async {
    try {
      var response = await _clients.get(url: ApiUrl.getWorkplaceTypeUrl());
      return List<JobTypeModel>.from(
        response["data"]!.map((x) => JobTypeModel.fromJson(x)),
      );
    } catch (e) {
      throw Exception("Failed to load categories: ${e.toString()}");
    }
  }
}
