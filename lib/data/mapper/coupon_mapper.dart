import 'package:pos/data/model/coupon_model.dart';

import '../../domain/entities/coupon_entity.dart';

extension CouponMapper on CouponEntity {
  CouponModel toModel() {
    return CouponModel(
      id: id,
      code: code,
      discountType: discountType,
      discountValue: discountValue,
      usageLimit: usageLimit,
      usageCount: usageCount,
      minOrderValue: minOrderValue,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}