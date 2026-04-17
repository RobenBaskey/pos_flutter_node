import 'package:pos/domain/entities/coupon_entity.dart';

abstract class CouponRepo {
  Future<bool> addCoupen({required CouponEntity coupon});
  Future<bool> updateCoupen({required String id, required CouponEntity coupon});
  Future<bool> deleteCoupen({required String id});
  Future<List<CouponEntity>> getCoupens();
}
