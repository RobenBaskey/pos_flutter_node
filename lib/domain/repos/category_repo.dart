import 'package:pos/domain/entities/category_entity.dart';

abstract class CategoryRepo {
  Future<bool> addCategory({
    required String name,
    String? parentId,
    required String image,
  });

  Future<List<CategoryEntity>> getCategories();
  Future<bool> deleteCategory(String id);
}
