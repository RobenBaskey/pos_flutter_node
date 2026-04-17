import '../../domain/entities/coupon_entity.dart';

class CouponModel extends CouponEntity {
  CouponModel({
    super.id,
    super.code,
    super.discountType,
    super.discountValue,
    super.usageLimit,
    super.usageCount,
    super.minOrderValue,
    super.createdAt,
    super.updatedAt,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json["_id"],
      code: json["code"],
      discountType: json["discount_type"],
      discountValue: json["discount_value"],
      usageLimit: json["usage_limit"],
      usageCount: json["usage_count"],
      minOrderValue: json["min_order_value"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "discount_type": discountType,
      "discount_value": discountValue,
      "usage_limit": usageLimit,
      "usage_count": usageCount ?? 0,
      "min_order_value": minOrderValue,
    };
  }
}
