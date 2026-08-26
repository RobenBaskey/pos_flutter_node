import '../../data/model/job_application_model.dart';
import '../../data/model/job_model.dart';
import '../../data/model/pagination_model.dart';

abstract class JobRepo {
  /// Jobs awaiting admin review (status pre-filtered server-side).
  Future<PaginationWithDataModel<List<JobModel>>> getPendingJobs({
    int page = 1,
    int perPage = 10,
  });

  /// Every job, optionally filtered by status/search.
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
