import 'package:file_picker/file_picker.dart';
import 'package:pos/domain/entities/category_entity.dart';

abstract class CategoryRepo {
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

  Future<List<CategoryEntity>> getCategories();
  Future<bool> deleteCategory(String id);
}
