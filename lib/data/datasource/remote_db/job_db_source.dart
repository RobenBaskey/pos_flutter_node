import 'package:pos/core/network/api_url.dart';
import 'package:pos/core/network/dio_client.dart';
import 'package:pos/data/model/job_model.dart';
import 'package:pos/data/model/pagination_model.dart';

abstract class JobDbSource {
  Future<void> insertJob(Map<String, dynamic> jobData);
  // Future<void> updateJob(String jobId, Map<String, dynamic> updatedData);
  // Future<void> deleteJob(String jobId);
  // Future<Map<String, dynamic>> getJobById(String jobId);
  Future<PaginationModel<JobModel>> getAllJobs({int page = 1, int limit = 10});
  Future<bool> updateJobStatus({required String id, required String status});
}

class JobDbSourceImpl implements JobDbSource {
  final DioClients _clients;
  JobDbSourceImpl(this._clients);

  // @override
  // Future<void> deleteJob(String jobId) {}

  @override
  Future<PaginationModel<JobModel>> getAllJobs({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _clients.get(
        url: ApiUrl.getAllJobsUrl(page: page, limit: limit),
        isTokenRequired: true,
      );

      return PaginationModel<JobModel>.fromResponse(
        response,
        itemKey: 'jobs',
        fromJsonT: JobModel.fromJson,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateJobStatus({
    required String id,
    required String status,
  }) async {
    try {
      await _clients.put(
        url: ApiUrl.updateJobStatusUrl(),
        body: {"job_id": id, "status": status},
        isTokenRequired: true,
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<Map<String, dynamic>> getJobById(String jobId) {}

  @override
  Future<void> insertJob(Map<String, dynamic> jobData) async {
    try {
      //await _clients.post(url: url, body: body)
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<void> updateJob(String jobId, Map<String, dynamic> updatedData) {}
}
