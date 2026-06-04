import '../../../core/network/api_url.dart';
import '../../../core/network/dio_client.dart';
import '../../model/job_type_model.dart';

abstract class JobTypeSource {
  Future<bool> addJobType({required String title, required bool isActive});
  Future<bool> updateJobType({
    required String id,
    required String title,
    bool? isActive,
  });
  Future<bool> deleteJobType({required String id});
  Future<List<JobTypeModel>> getJobTypes();
}

class JobTypeSourceImpl extends JobTypeSource {
  final DioClients _clients;
  JobTypeSourceImpl(this._clients);

  @override
  Future<bool> addJobType({
    required String title,
    required bool isActive,
  }) async {
    try {
      await _clients.post(
        url: ApiUrl.addJobTypeUrl(),
        body: {"title": title, "is_active": isActive},
        isTokenRequired: true,
      );
      return true;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteJobType({required String id}) async {
    try {
      await _clients.delete(
        url: ApiUrl.deleteJobTypeUrl(id),
        isTokenRequired: true,
      );
      return true;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> updateJobType({
    required String id,
    required String title,
    bool? isActive,
  }) async {
    try {
      await _clients.put(
        url: ApiUrl.updateJobTypeUrl(),
        body: {"id": id, "title": title, "status": isActive},
        isTokenRequired: true,
      );
      return true;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<JobTypeModel>> getJobTypes() async {
    try {
      var response = await _clients.get(url: ApiUrl.getJobTypeUrl());
      return List<JobTypeModel>.from(
        response["data"]!.map((x) => JobTypeModel.fromJson(x)),
      );
    } catch (e) {
      throw Exception("Failed to load categories: ${e.toString()}");
    }
  }
}
