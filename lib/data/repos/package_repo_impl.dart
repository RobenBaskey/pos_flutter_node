import 'package:pos/data/datasource/remote_db/package_db_source.dart';
import 'package:pos/data/mapper/package_mapper.dart';
import 'package:pos/data/model/package_model.dart';
import 'package:pos/domain/entities/package_entity.dart';
import 'package:pos/domain/repos/package_repo.dart';

class PackageRepoImpl extends PackageRepo {
  final PackageDbSource _source;
  PackageRepoImpl(this._source);

  @override
  Future<bool> deletePackage({required String id}) {
    return _source.deletePackage(id: id);
  }

  @override
  Future<List<PackageModel>> getPackages() {
    return _source.getPackages();
  }

  @override
  Future<PackageModel?> getSinglePackage(String id) {
    return _source.getSinglePackage(id);
  }

  @override
  Future<bool> insertPackage({
    required PackageEntity model,
    required String imagePath,
  }) {
    return _source.insertPackage(model: model.toModel(), imagePath: imagePath);
  }

  @override
  Future<bool> updatePackage({
    required String id,
    required PackageEntity model,
    String? imagePath,
  }) {
    return _source.updatePackage(
      id: id,
      model: model.toModel(),
      imagePath: imagePath,
    );
  }

  @override
  Future<bool> insertContent({
    required String packageId,
    required String name,
    required bool isActive,
    int? limit,
  }) {
    return _source.insertContent(
      packageId: packageId,
      name: name,
      isActive: isActive,
      limit: limit
    );
  }

  @override
  Future<bool> updateContent({
    required String packageId,
    required String contentId,
    required String name,
    required bool isActive,
    int? limit,
  }) {
    return _source.updateContent(
      packageId: packageId,
      contentId: contentId,
      name: name,
      isActive: isActive,
      limit: limit
    );
  }

  @override
  Future<bool> deleteContent({
    required String packageId,
    required String contentId,
  }) {
    return _source.deleteContent(packageId: packageId, contentId: contentId);
  }
}
