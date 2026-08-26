import 'package:pos/data/datasource/remote_db/job_db_source.dart';
import 'package:pos/domain/repos/job_repo.dart';

import '../model/job_application_model.dart';
import '../model/job_model.dart';
import '../model/pagination_model.dart';

class JobRepoImpl extends JobRepo {
  final JobDbSource _jobDbSource;
  JobRepoImpl(this._jobDbSource);

  @override
  Future<PaginationWithDataModel<List<JobModel>>> getPendingJobs({
    int page = 1,
    int perPage = 10,
  }) {
    return _jobDbSource.getPendingJobs(page: page, perPage: perPage);
  }

  @override
  Future<PaginationWithDataModel<List<JobModel>>> getAllJobs({
    int page = 1,
    int perPage = 10,
    String? status,
    String? search,
  }) {
    return _jobDbSource.getAllJobs(
      page: page,
      perPage: perPage,
      status: status,
      search: search,
    );
  }

  @override
  Future<JobModel> getSingleJob(String id) {
    return _jobDbSource.getSingleJob(id);
  }

  @override
  Future<PaginationWithDataModel<List<JobApplicationModel>>> getJobApplicants(
    String jobId, {
    int page = 1,
    int perPage = 10,
    String? status,
  }) {
    return _jobDbSource.getJobApplicants(
      jobId,
      page: page,
      perPage: perPage,
      status: status,
    );
  }

  @override
  Future<void> approveJob(String jobId) {
    return _jobDbSource.approveJob(jobId);
  }

  @override
  Future<void> rejectJob({required String jobId, required String reason}) {
    return _jobDbSource.rejectJob(jobId: jobId, reason: reason);
  }

  @override
  Future<void> requestJobCorrection({
    required String jobId,
    required String note,
  }) {
    return _jobDbSource.requestJobCorrection(jobId: jobId, note: note);
  }

  @override
  Future<void> cancelJob(String jobId) {
    return _jobDbSource.cancelJob(jobId);
  }
}
