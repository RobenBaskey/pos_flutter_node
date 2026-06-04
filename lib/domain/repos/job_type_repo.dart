import '../entities/job_type_entity.dart';

abstract class JobTypeRepo {
  Future<bool> addJobType({required String title, required bool isActive});
  Future<bool> updateJobType({
    required String id,
    required String title,
    bool? isActive,
  });
  Future<bool> deleteJobType({required String id});
  Future<List<JobTypeEntity>> getJobTypes();
}
