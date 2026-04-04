import '../entities/job_type_entity.dart';

abstract class JobTypeRepo {
  Future<bool> addJobType({required String title});
  Future<bool> updateJobType({
    required String id,
    required String title,
    String isActive = "1",
  });
  Future<bool> deleteJobType({required String id});
  Future<List<JobTypeEntity>> getJobTypes();
}
