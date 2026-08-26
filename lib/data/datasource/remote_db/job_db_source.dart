import 'package:pos/core/network/api_url.dart';
import 'package:pos/core/network/dio_client.dart';
import 'package:pos/data/model/job_application_model.dart';
import 'package:pos/data/model/job_model.dart';
import 'package:pos/data/model/pagination_model.dart';

import '../../model/success_response_model.dart';

abstract class JobDbSource {
  Future<PaginationWithDataModel<List<JobModel>>> getPendingJobs({
    int page = 1,
    int perPage = 10,
  });

  Future<PaginationWithDataModel<List<JobModel>>> getAllJobs({
    int page = 1,
    int perPage = 10,
    String? status,
    String? search,
  });

  Future<JobModel> getSingleJob(String id);

  Future<PaginationWithDataModel<List<JobApplicationModel>>> getJobApplicants(
    String jobId, {
    int page = 1,
    int perPage = 10,
    String? status,
  });

  Future<void> approveJob(String jobId);
  Future<void> rejectJob({required String jobId, required String reason});
  Future<void> requestJobCorrection({
    required String jobId,
    required String note,
  });
  Future<void> cancelJob(String jobId);
}

class JobDbSourceImpl implements JobDbSource {
  final DioClients _clients;
  JobDbSourceImpl(this._clients);

  @override
  Future<PaginationWithDataModel<List<JobModel>>> getPendingJobs({
    int page = 1,
    int perPage = 10,
  }) async {
    final response = await _clients.get(
      url: ApiUrl.getPendingJobsUrl(page: page, perPage: perPage),
      isTokenRequired: true,
    );

    return SuccessResponse<PaginationWithDataModel<List<JobModel>>>.fromJson(
      response,
      (data) => PaginationWithDataModel<List<JobModel>>.fromJson(
        json: data,
        fromJsonT: (json) =>
            (json as List).map((x) => JobModel.fromJson(x)).toList(),
        keyName: "jobs",
      ),
    ).data;
  }

  @override
  Future<PaginationWithDataModel<List<JobModel>>> getAllJobs({
    int page = 1,
    int perPage = 10,
    String? status,
    String? search,
  }) async {
    final response = await _clients.get(
      url: ApiUrl.getAllJobsUrl(
        page: page,
        perPage: perPage,
        status: status,
        search: search,
      ),
      isTokenRequired: true,
    );

    return SuccessResponse<PaginationWithDataModel<List<JobModel>>>.fromJson(
      response,
      (data) => PaginationWithDataModel<List<JobModel>>.fromJson(
        json: data,
        fromJsonT: (json) =>
            (json as List).map((x) => JobModel.fromJson(x)).toList(),
        keyName: "jobs",
      ),
    ).data;
  }

  @override
  Future<JobModel> getSingleJob(String id) async {
    final response = await _clients.get(
      url: ApiUrl.getSingleJobUrl(id),
      isTokenRequired: true,
    );

    return SuccessResponse<JobModel>.fromJson(
      response,
      (data) => JobModel.fromJson(data),
    ).data;
  }

  @override
  Future<PaginationWithDataModel<List<JobApplicationModel>>>
  getJobApplicants(
    String jobId, {
    int page = 1,
    int perPage = 10,
    String? status,
  }) async {
    final response = await _clients.get(
      url: ApiUrl.getJobApplicantsUrl(
        jobId: jobId,
        page: page,
        perPage: perPage,
        status: status,
      ),
      isTokenRequired: true,
    );

    return SuccessResponse<
      PaginationWithDataModel<List<JobApplicationModel>>
    >.fromJson(
      response,
      (data) => PaginationWithDataModel<List<JobApplicationModel>>.fromJson(
        json: data,
        fromJsonT: (json) => (json as List)
            .map((x) => JobApplicationModel.fromJson(x))
            .toList(),
        keyName: "applicants",
      ),
    ).data;
  }

  @override
  Future<void> approveJob(String jobId) async {
    await _clients.put(
      url: ApiUrl.approveJobUrl(),
      body: {"job_id": jobId},
      isTokenRequired: true,
    );
  }

  @override
  Future<void> rejectJob({
    required String jobId,
    required String reason,
  }) async {
    await _clients.put(
      url: ApiUrl.rejectJobUrl(),
      body: {"job_id": jobId, "reason": reason},
      isTokenRequired: true,
    );
  }

  @override
  Future<void> requestJobCorrection({
    required String jobId,
    required String note,
  }) async {
    await _clients.put(
      url: ApiUrl.requestJobCorrectionUrl(),
      body: {"job_id": jobId, "note": note},
      isTokenRequired: true,
    );
  }

  @override
  Future<void> cancelJob(String jobId) async {
    await _clients.put(
      url: ApiUrl.cancelJobUrl(),
      body: {"job_id": jobId},
      isTokenRequired: true,
    );
  }
}
