import '../entities/job_type_entity.dart';

abstract class WorkplaceTypeRepo {
  Future<bool> addWorkplaceType({
    required String title,
    required String description,
    bool? isActive,
  });
  Future<bool> updateWorkplaceType({
    required String id,
    required String title,
    bool? isActive,
  });
  Future<bool> deleteWorkplaceType({required String id});
  Future<List<JobTypeEntity>> getWorkplaceTypes();
}
