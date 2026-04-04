import 'package:pos/core/network/dio_client.dart';

import '../../../core/network/api_url.dart';
import '../../model/category_model.dart';

abstract class CategoryDbSource {
  Future<bool> addCategory({
    required String name,
    String? parentId,
    required String image,
  });
  Future<bool> updateCategory({
    required String id,
    required String name,
    String? parentId,
    String? image,
  });
  Future<bool> deleteCategory({required String id});
  Future<List<CategoryModel>> getCategories();
}

class CategoryDbSourceImpl extends CategoryDbSource {
  final DioClients dioClients;
  CategoryDbSourceImpl(this.dioClients);

  @override
  Future<bool> addCategory({
    required String name,
    String? parentId,
    required String image,
  }) async {
    try {
      await dioClients.postWithFile(
        url: ApiUrl.addCategoryUrl(),
        body: parentId == null
            ? {"name": name}
            : {"name": name, "category_id": parentId, "is_subcategory": 1},
        isTokenRequired: true,
        filePath: image,
        fileKeyName: "image",
      );
      return true;
    } catch (e) {
      throw Exception("Failed to add category: ${e.toString()}");
    }
  }

  @override
  Future<bool> deleteCategory({required String id}) async {
    try {
      await dioClients.delete(
        url: ApiUrl.deleteCategoryUrl(id),
        isTokenRequired: true,
      );
      return true;
    } catch (e) {
      throw Exception("Failed to add category: ${e.toString()}");
    }
  }

  @override
  Future<bool> updateCategory({
    required String id,
    required String name,
    String? parentId,
    String? image,
  }) async {
    try {
      if (image != null) {
        await dioClients.putWithFile(
          url: ApiUrl.updateCategoryUrl(),
          body: {"id": id, "name": name},
          isTokenRequired: true,
          filePath: image,
          fileKeyName: "image",
        );
        return true;
      } else {
        await dioClients.put(
          url: ApiUrl.updateCategoryUrl(),
          body: {"id": id, "name": name},
          isTokenRequired: true,
        );
        return true;
      }
    } catch (e) {
      throw Exception("Failed to add category: ${e.toString()}");
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await dioClients.get(
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
