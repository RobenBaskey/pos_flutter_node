import 'package:pos/data/datasource/remote_db/job_db_source.dart';
import 'package:pos/domain/entities/job_entity.dart';
import 'package:pos/domain/entities/pagination_entity.dart';
import 'package:pos/domain/repos/job_repo.dart';

class JobRepoImpl extends JobRepo {
  final JobDbSource _jobDbSource;
  JobRepoImpl(this._jobDbSource);

  @override
  Future<PaginationEntity<JobEntity>> getAllJobs({
    int page = 1,
    int limit = 10,
  }) async {
    final response = await _jobDbSource.getAllJobs(page: page, limit: limit);

    return PaginationEntity<JobEntity>(
      items: response.items,
      lastPage: response.lastPage,
      perPage: response.perPage,
      total: response.total,
      totalPages: response.totalPages,
    );
  }

  @override
  Future<bool> updateJobStatus({required String id, required String status}) {
    return _jobDbSource.updateJobStatus(id: id, status: status);
  }
}
