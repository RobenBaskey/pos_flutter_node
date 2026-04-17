class CouponEntity {
  final String? id;
  final String? code;
  final String? discountType;
  final int? discountValue;
  final int? usageLimit;
  final int? usageCount;
  final int? minOrderValue;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CouponEntity({
    this.id,
    this.code,
    this.discountType,
    this.discountValue,
    this.usageLimit,
    this.usageCount,
    this.minOrderValue,
    this.createdAt,
    this.updatedAt,
  });
}
