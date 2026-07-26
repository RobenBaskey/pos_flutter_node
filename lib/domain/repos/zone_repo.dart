import '../../data/model/zone_model.dart';

abstract class ZoneRepo {
  Future<ZoneModel?> insertZone(ZoneModel model);
  Future<List<ZoneModel>> getZones();
  Future<ZoneModel?> updateZone(ZoneModel model, String id);
  Future<bool> deleteZone(String id);
}
