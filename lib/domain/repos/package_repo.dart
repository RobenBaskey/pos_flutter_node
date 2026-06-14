import 'package:file_picker/file_picker.dart';
import 'package:pos/domain/entities/package_entity.dart';

abstract class PackageRepo {
  Future<bool> insertPackage({
    required PackageEntity model,
    required PlatformFile file,
  });
  Future<List<PackageEntity>> getPackages();
  Future<PackageEntity?> getSinglePackage(String id);
  Future<bool> updatePackage({
    required String id,
    required PackageEntity model,
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
