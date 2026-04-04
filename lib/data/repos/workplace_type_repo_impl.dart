import 'package:pos/data/datasource/remote_db/workplace_type_source.dart';
import 'package:pos/domain/repos/workplace_type_repo.dart';

import '../../domain/entities/job_type_entity.dart';
import '../datasource/remote_db/job_type_source.dart';

class WorkplaceTypeRepoImpl extends WorkplaceTypeRepo {
  final WorkplaceTypeSource _source;
  WorkplaceTypeRepoImpl(this._source);
  @override
  Future<bool> addWorkplaceType({required String title, required String description}) {
    return _source.addWorkplaceType(title: title, description: description);
  }

  @override
  Future<bool> deleteWorkplaceType({required String id}) {
    return _source.deleteWorkplaceType(id: id);
  }

  @override
  Future<bool> updateWorkplaceType({
    required String id,
    required String title,
    String isActive = "1",
  }) {
    return _source.updateWorkplaceType(id: id, title: title, isActive: isActive);
  }

  @override
  Future<List<JobTypeEntity>> getWorkplaceTypes() async {
    return _source.getWorkplaceTypes();
  }
}
