import 'package:pos/data/datasource/remote_db/zone_db_source.dart';
import 'package:pos/data/model/zone_model.dart';
import 'package:pos/domain/repos/zone_repo.dart';

class ZoneRepoImpl extends ZoneRepo {
  final ZoneDbSource _dbSource;
  ZoneRepoImpl(this._dbSource);

  @override
  Future<List<ZoneModel>> getZones() {
    return _dbSource.getZones();
  }

  @override
  Future<ZoneModel?> insertZone(ZoneModel model) {
    return _dbSource.insertZone(model);
  }

  @override
  Future<bool> deleteZone(String id) {
    return _dbSource.deleteZone(id);
  }

  @override
  Future<ZoneModel?> updateZone(ZoneModel model, String id) {
    return _dbSource.updateZone(model, id);
  }
}
