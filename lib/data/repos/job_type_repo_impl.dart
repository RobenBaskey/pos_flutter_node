import '../../domain/entities/job_type_entity.dart';
import '../../domain/repos/job_type_repo.dart';
import '../datasource/remote_db/job_type_source.dart';

class JobTypeRepoImpl extends JobTypeRepo {
  final JobTypeSource _source;
  JobTypeRepoImpl(this._source);
  @override
  Future<bool> addJobType({required String title}) {
    return _source.addJobType(title: title);
  }

  @override
  Future<bool> deleteJobType({required String id}) {
    return _source.deleteJobType(id: id);
  }

  @override
  Future<bool> updateJobType({
    required String id,
    required String title,
    String isActive = "1",
  }) {
    return _source.updateJobType(id: id, title: title, isActive: isActive);
  }

  @override
  Future<List<JobTypeEntity>> getJobTypes() async {
    return _source.getJobTypes();
  }
}
