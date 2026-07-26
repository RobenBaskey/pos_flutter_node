import 'package:file_picker/file_picker.dart';
import 'package:pos/core/network/dio_client.dart';
import 'package:pos/data/model/banner_model.dart';

import '../../../core/network/api_url.dart';
import '../../model/category_model.dart';

abstract class BannerDbSource {
  Future<List<BannerModel>> getBanners();
  Future<void> addBanner(BannerModel banner, PlatformFile file);
  Future<void> updateBanner(String bannerId, Map<String, dynamic> updatedData);
  Future<void> deleteBanner(String bannerId);
  Future<List<CategoryModel>> getCategories();
}

class BannerDbSourceImpl implements BannerDbSource {
  final DioClients dioClient;

  BannerDbSourceImpl({required this.dioClient});

  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      var response = await dioClient.get(
        url: ApiUrl.getBannerUrl(),
        isTokenRequired: true,
      );
      return List<BannerModel>.from(
        response["data"]!.map((x) => BannerModel.fromJson(x)),
      );
    } catch (e) {
      throw Exception("Failed to load banners: ${e.toString()}");
    }
  }

  @override
  Future<void> addBanner(BannerModel banner, PlatformFile file) async {
    try {
      await dioClient.postWithFile(
        url: ApiUrl.insertBannerUrl(),
        body: {
          "name": banner.name,
          "category_id": banner.categoryId,
          "status": banner.isActive,
          "offer_ammount": banner.offerAmmount,
          "is_percentage": banner.isPercentage,
        },
        isTokenRequired: true,
        file: file,
        fileKeyName: "image",
      );
    } catch (e) {
      throw Exception("Failed to add category: ${e.toString()}");
    }
  }

  @override
  Future<void> updateBanner(
    String bannerId,
    Map<String, dynamic> updatedData,
  ) async {
    await dioClient.put(url: '/banners/$bannerId', body: updatedData);
  }

  @override
  Future<void> deleteBanner(String bannerId) async {
    await dioClient.delete(url: '/banners/$bannerId');
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await dioClient.get(
        url: ApiUrl.getCategoryUrl(),
        isTokenRequired: true,
      );
      return List<CategoryModel>.from(
        response["data"]!.map((x) => CategoryModel.fromJson(x)),
      );
    } catch (e) {
      throw Exception("Failed to load categories: ${e.toString()}");
    }
  }
}
