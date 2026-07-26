class BannerModel {
  final String? id;
  final String? name;
  final String? image;
  final String? categoryId;
  final int? offerAmmount;
  final bool? isPercentage;
  final bool? isActive;
  final String? endTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BannerModel({
    this.id,
    this.name,
    this.image,
    this.categoryId,
    this.offerAmmount,
    this.isPercentage,
    this.isActive,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  BannerModel copyWith({
    String? id,
    String? name,
    String? image,
    String? categoryId,
    int? offerAmmount,
    bool? isPercentage,
    bool? isActive,
    String? endTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BannerModel(
    id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
    categoryId: categoryId ?? this.categoryId,
    offerAmmount: offerAmmount ?? this.offerAmmount,
    isPercentage: isPercentage ?? this.isPercentage,
    isActive: isActive ?? this.isActive,
    endTime: endTime ?? this.endTime,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    categoryId: json["category_id"],
    offerAmmount: json["offer_ammount"],
    isPercentage: json["is_percentage"],
    isActive: json["is_active"],
    endTime: json["end_time"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "category_id": categoryId,
    "offer_ammount": offerAmmount,
    "is_percentage": isPercentage,
    "is_active": isActive,
    "end_time": endTime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
