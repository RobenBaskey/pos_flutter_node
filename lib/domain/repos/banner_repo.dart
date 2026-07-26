import 'package:file_picker/file_picker.dart';
import 'package:pos/data/model/banner_model.dart';

import '../entities/category_entity.dart';

abstract class BannerRepo {
  Future<List<BannerModel>> getBanners();
  Future<void> addBanner(BannerModel banner, PlatformFile imageFile);
  Future<void> updateBanner(String bannerId, Map<String, dynamic> updatedData);
  Future<void> deleteBanner(String bannerId);
  Future<List<CategoryEntity>> getCategories();
}