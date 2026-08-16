import 'package:pos/data/datasource/remote_db/job_db_source.dart';
import 'package:pos/domain/repos/job_repo.dart';

import '../model/job_model.dart';
import '../model/pagination_model.dart';

class JobRepoImpl extends JobRepo {
  final JobDbSource _jobDbSource;
  JobRepoImpl(this._jobDbSource);

  @override
  Future<PaginationWithDataModel<List<JobModel>>> getAllJobs({
    int page = 1,
    int limit = 10,
  }) async {
    return await _jobDbSource.getAllJobs(page: page, limit: limit);
  }

  @override
  Future<bool> updateJobStatus({required String id, required String status}) {
    return _jobDbSource.updateJobStatus(id: id, status: status);
  }
}
