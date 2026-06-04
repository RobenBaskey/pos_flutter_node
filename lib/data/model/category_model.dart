import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    super.id,
    super.name,
    super.image,
    super.isSubcategory,
    super.categoryId,
    super.status,
    super.createdAt,
    super.updatedAt,
    super.children,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      isSubcategory: json['is_subcategory'] as bool?,
      categoryId: json['category_id'] as String?,
      status: json['status'] as bool?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      children: json["children"] == null
          ? []
          : List<CategoryModel>.from(
              json["children"]!.map((x) => CategoryModel.fromJson(x)),
            ),
    );
  }
}
