import 'package:pos/data/datasource/remote_db/workplace_type_source.dart';
import 'package:pos/domain/repos/workplace_type_repo.dart';

import '../../domain/entities/job_type_entity.dart';

class WorkplaceTypeRepoImpl extends WorkplaceTypeRepo {
  final WorkplaceTypeSource _source;
  WorkplaceTypeRepoImpl(this._source);
  @override
  Future<bool> addWorkplaceType({required String title, required String description, bool? isActive}) {
    return _source.addWorkplaceType(title: title, description: description, isActive: isActive);
  }

  @override
  Future<bool> deleteWorkplaceType({required String id}) {
    return _source.deleteWorkplaceType(id: id);
  }

  @override
  Future<bool> updateWorkplaceType({
    required String id,
    required String title,
    bool? isActive
  }) {
    return _source.updateWorkplaceType(id: id, title: title, isActive: isActive);
  }

  @override
  Future<List<JobTypeEntity>> getWorkplaceTypes() async {
    return _source.getWorkplaceTypes();
  }
}
