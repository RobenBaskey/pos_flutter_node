import 'package:file_picker/file_picker.dart';
import 'package:pos/data/datasource/remote_db/category_db_source.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/repos/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  final CategoryDbSource categoryDbSource;
  CategoryRepoImpl(this.categoryDbSource);
  @override
  Future<bool> addCategory({
    required String name,
    required PlatformFile file,
    String? parentId,
    bool? status,
  }) {
    return categoryDbSource.addCategory(
      name: name,
      parentId: parentId,
      file: file,
      status: status,
    );
  }

  @override
  Future<List<CategoryEntity>> getCategories() {
    return categoryDbSource.getCategories();
  }

  @override
  Future<bool> deleteCategory(String id) {
    return categoryDbSource.deleteCategory(id: id);
  }

  @override
  Future<bool> updateCategory({
    required String id,
    required String name,
    String? parentId,
    PlatformFile? file,
    bool? status,
  }) {
    return categoryDbSource.updateCategory(
      id: id,
      name: name,
      file: file,
      status: status,
      parentId: parentId,
    );
  }
}
