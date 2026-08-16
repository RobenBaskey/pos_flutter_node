import '../../data/model/job_model.dart';
import '../../data/model/pagination_model.dart';

abstract class JobRepo {
  Future<PaginationWithDataModel<List<JobModel>>> getAllJobs({
    int page = 1,
    int limit = 10,
  });

  Future<bool> updateJobStatus({required String id, required String status});
}
