import 'package:pos/domain/entities/job_entity.dart';
import 'package:pos/domain/entities/pagination_entity.dart';

abstract class JobRepo {
  Future<PaginationEntity<JobEntity>> getAllJobs({
    int page = 1,
    int limit = 10,
  });

  Future<bool> updateJobStatus({required String id, required String status});
}
