import 'package:file_picker/file_picker.dart';
import 'package:pos/core/network/api_url.dart';
import 'package:pos/core/network/dio_client.dart';
import 'package:pos/data/model/package_model.dart';

abstract class PackageDbSource {
  Future<bool> insertPackage({
    required PackageModel model,
    required PlatformFile file,
  });
  Future<List<PackageModel>> getPackages();
  Future<PackageModel?> getSinglePackage(String id);
  Future<bool> updatePackage({
    required String id,
    required PackageModel model,
    PlatformFile? file,
  });
  Future<bool> deletePackage({required String id});
  Future<bool> insertContent({
    required String packageId,
    required String name,
    required bool isActive,
    int? limit,
  });
  Future<bool> updateContent({
    required String packageId,
    required String contentId,
    required String name,
    required bool isActive,
    int? limit,
  });
  Future<bool> deleteContent({
    required String packageId,
    required String contentId,
  });
}

class PackageDbSourceImpl extends PackageDbSource {
  final DioClients _clients;
  PackageDbSourceImpl(this._clients);

  @override
  Future<bool> insertPackage({
    required PackageModel model,
    required PlatformFile file,
  }) async {
    try {
      await _clients.postWithFile(
        url: ApiUrl.insertPackageUrl(),
        body: model.toJson(),
        file: file,
        fileKeyName: "image",
        isTokenRequired: true,
      );
      return true;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<PackageModel>> getPackages() async {
    try {
      var response = await _clients.get(
        url: ApiUrl.getPackageUrl(),
        isTokenRequired: true,
      );
      if (response["data"] != null) {
        return List<PackageModel>.from(
          response["data"]!.map((x) => PackageModel.fromJson(x)),
        );
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PackageModel?> getSinglePackage(String id) async {
    try {
      var response = await _clients.get(
        url: ApiUrl.getSinglePackageUrl(id),
        isTokenRequired: true,
      );
      return PackageModel.fromJson(response["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deletePackage({required String id}) async {
    try {
      await _clients.delete(
        url: ApiUrl.deletePackageUrl(id),
        isTokenRequired: true,
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updatePackage({
    required String id,
    required PackageModel model,
    PlatformFile? file,
  }) async {
    var body = {"package_id": id, "name": model.name, "price": model.price};
    if (file != null) {
      try {
        await _clients.putWithFile(
          url: ApiUrl.updatePackageUrl(),
          body: body,
          file: file,
          fileKeyName: "image",
          isTokenRequired: true,
        );
        return true;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      try {
        await _clients.put(
          url: ApiUrl.updatePackageUrl(),
          body: body,
          isTokenRequired: true,
        );
        return true;
      } on Exception catch (_) {
        rethrow;
      }
    }
  }

  @override
  Future<bool> deleteContent({
    required String packageId,
    required String contentId,
  }) async {
    try {
      await _clients.delete(
        url: ApiUrl.deletePackageContentUrl(
          packageId: packageId,
          contentId: contentId,
        ),
        isTokenRequired: true,
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> insertContent({
    required String packageId,
    required String name,
    required bool isActive,
    int? limit,
  }) async {
    try {
      await _clients.post(
        url: ApiUrl.insertPackageContentUrl(),
        body: {
          "package_id": packageId,
          "name": name,
          "is_active": isActive,
          "limit": limit,
        },
        isTokenRequired: true,
      );
      return true;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> updateContent({
    required String packageId,
    required String contentId,
    required String name,
    required bool isActive,
    int? limit,
  }) async {
    try {
      await _clients.put(
        url: ApiUrl.updatePackageContentUrl(),
        body: {
          "package_id": packageId,
          "id": contentId,
          "name": name,
          "is_active": isActive,
          "limit": limit,
        },
        isTokenRequired: true,
      );
      return true;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
