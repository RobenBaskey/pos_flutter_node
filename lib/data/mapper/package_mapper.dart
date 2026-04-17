import '../../domain/entities/package_entity.dart';
import '../model/package_model.dart';

extension PackageEntityMapper on PackageEntity {
  PackageModel toModel() {
    return PackageModel(
      id: id,
      name: name,
      contents: contents,
      createdAt: createdAt,
      image: image,
      isActive: isActive,
      isMonthly: isMonthly,
      price: price,
      updatedAt: updatedAt,
    );
  }
}
