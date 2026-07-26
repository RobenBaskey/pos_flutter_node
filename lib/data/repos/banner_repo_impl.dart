import 'package:file_picker/file_picker.dart';
import 'package:pos/domain/entities/category_entity.dart';

import '../../domain/repos/banner_repo.dart';
import '../datasource/remote_db/banner_db_source.dart';
import '../model/banner_model.dart';

class BannerRepoImpl implements BannerRepo {
  final BannerDbSource bannerDbSource;

  BannerRepoImpl({required this.bannerDbSource});

  @override
  Future<List<BannerModel>> getBanners() async {
    return await bannerDbSource.getBanners();
  }

  @override
  Future<void> addBanner(BannerModel banner, PlatformFile file) async {
    await bannerDbSource.addBanner(banner, file);
  }

  @override
  Future<void> updateBanner(
    String bannerId,
    Map<String, dynamic> updatedData,
  ) async {
    await bannerDbSource.updateBanner(bannerId, updatedData);
  }

  @override
  Future<void> deleteBanner(String bannerId) async {
    await bannerDbSource.deleteBanner(bannerId);
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    return await bannerDbSource.getCategories();
  }
}
