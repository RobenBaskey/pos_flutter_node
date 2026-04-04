class CategoryEntity {
  final String? id;
  final String? name;
  final String? image;
  final bool? isSubcategory;
  final String? categoryId;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<CategoryEntity>? children;

  CategoryEntity({
    this.id,
    this.name,
    this.image,
    this.isSubcategory,
    this.categoryId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.children
  });
}
