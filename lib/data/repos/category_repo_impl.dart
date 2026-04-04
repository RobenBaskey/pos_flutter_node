import 'package:pos/data/datasource/remote_db/category_db_source.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/repos/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  final CategoryDbSource categoryDbSource;
  CategoryRepoImpl(this.categoryDbSource);
  @override
  Future<bool> addCategory({
    required String name,
    String? parentId,
    required String image,
  }) {
    return categoryDbSource.addCategory(
      name: name,
      parentId: parentId,
      image: image,
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
}
