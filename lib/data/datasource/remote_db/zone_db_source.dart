import 'package:pos/core/network/api_url.dart';
import 'package:pos/core/network/dio_client.dart';
import 'package:pos/data/model/zone_model.dart';

abstract class ZoneDbSource {
  Future<ZoneModel?> insertZone(ZoneModel model);
  Future<List<ZoneModel>> getZones();
  Future<ZoneModel?> updateZone(ZoneModel model, String id);
  Future<bool> deleteZone(String id);
}

class ZoneDbSourceImpl extends ZoneDbSource {
  final DioClients _clients;
  ZoneDbSourceImpl(this._clients);

  @override
  Future<List<ZoneModel>> getZones() async {
    try {
      final response = await _clients.get(
        url: ApiUrl.getZone,
        isTokenRequired: true,
      );
      if (response["data"] == null) {
        return [];
      }
      return List<ZoneModel>.from(
        response["data"]!.map((x) => ZoneModel.fromJson(x)),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ZoneModel?> insertZone(ZoneModel model) async {
    try {
      final response = await _clients.post(
        url: ApiUrl.insertZone,
        body: model.toMap(),
        isTokenRequired: true,
      );
      if (response["data"] == null) {
        return null;
      }
      return ZoneModel.fromJson(response["data"]);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<bool> deleteZone(String id) async {
    try {
      await _clients.delete(
        url: "${ApiUrl.deleteZone}?id=$id",
        isTokenRequired: true,
      );
      return true;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ZoneModel?> updateZone(ZoneModel model, String id) async {
    try {
      print(model.toMap());
      final response = await _clients.put(
        url: "${ApiUrl.updateZone}?id=$id",
        body: model.toMap(),
        isTokenRequired: true,
      );
      if (response["data"] == null) {
        return null;
      }
      return ZoneModel.fromJson(response["data"]);
    } on Exception {
      rethrow;
    }
  }
}
