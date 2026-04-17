import 'package:pos/domain/entities/package_entity.dart';

class PackageModel extends PackageEntity {
  PackageModel({
    super.id,
    super.name,
    super.price,
    super.image,
    super.isMonthly,
    super.isActive,
    super.contents,
    super.createdAt,
    super.updatedAt,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
    id: json["_id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
    isMonthly: json["is_monthly"],
    isActive: json["is_active"],
    contents: json["contents"] == null
        ? []
        : List<ContentModel>.from(
            json["contents"]!.map((x) => ContentModel.fromJson(x)),
          ),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": "$price",
    "is_monthly": isMonthly == true ? "1" : "0",
    "is_active": isActive == true ? "1" : "0",
  };
}

class ContentModel extends ContentEntity {
  ContentModel({super.id, super.name, super.isActive});

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
    id: json["_id"],
    name: json["name"],
    isActive: json["is_active"],
  );
}
