import 'package:file_picker/file_picker.dart';
import 'package:pos/core/network/dio_client.dart';

import '../../../core/network/api_url.dart';
import '../../model/category_model.dart';

abstract class CategoryDbSource {
  Future<bool> addCategory({
    required String name,
    required PlatformFile file,
    String? parentId,
    bool? status,
  });
  Future<bool> updateCategory({
    required String id,
    required String name,
    String? parentId,
    PlatformFile? file,
    bool? status,
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
    required PlatformFile file,
    String? parentId,
    bool? status,
  }) async {
    try {
      await dioClients.postWithFile(
        url: ApiUrl.addCategoryUrl(),
        body: parentId == null
            ? {"name": name, "status": status}
            : {
                "name": name,
                "category_id": parentId,
                "is_subcategory": true,
                "status": status,
              },
        isTokenRequired: true,
        file: file,
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
    PlatformFile? file,
    bool? status,
  }) async {
    try {
      Map<String, dynamic> body = {};
      if (parentId == null) {
        body = {"id": id, "name": name, "status": status};
      } else {
        body = {
          "id": id,
          "name": name,
          "category_id": parentId,
          "is_subcategory": true,
          "status": status,
        };
      }
      print(body);
      if (file != null) {
        await dioClients.putWithFile(
          url: ApiUrl.updateCategoryUrl(),
          body: body,
          isTokenRequired: true,
          file: file,
          fileKeyName: "image",
        );
        return true;
      } else {
        await dioClients.put(
          url: ApiUrl.updateCategoryUrl(),
          body: body,
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
