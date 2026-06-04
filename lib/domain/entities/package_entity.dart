class PackageEntity {
  final String? id;
  final String? name;
  final int? price;
  final String? image;
  final bool? isMonthly;
  final bool? isActive;
  final List<ContentEntity>? contents;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PackageEntity({
    this.id,
    this.name,
    this.price,
    this.image,
    this.isMonthly,
    this.isActive,
    this.contents,
    this.createdAt,
    this.updatedAt,
  });
}

class ContentEntity {
  final String? id;
  final String? name;
  final bool? isActive;
  final int? limit;

  ContentEntity({this.id, this.name, this.isActive, this.limit});
}
