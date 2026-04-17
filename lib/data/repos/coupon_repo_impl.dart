import 'package:pos/data/mapper/coupon_mapper.dart';
import 'package:pos/domain/repos/coupon_repo.dart';

import '../../domain/entities/coupon_entity.dart';
import '../datasource/remote_db/coupen_db_source.dart';

class CouponRepoImpl extends CouponRepo {
  final CouponDbSource couponDBSource;
  CouponRepoImpl(this.couponDBSource);

  @override
  Future<bool> addCoupen({required CouponEntity coupon}) {
    return couponDBSource.addCoupen(coupon: coupon.toModel());
  }

  @override
  Future<bool> updateCoupen({
    required String id,
    required CouponEntity coupon,
  }) {
    return couponDBSource.updateCoupen(id: id, coupon: coupon.toModel());
  }
  
  @override
  Future<bool> deleteCoupen({required String id}) {
    return couponDBSource.deleteCoupen(id: id);
  }

  @override
  Future<List<CouponEntity>> getCoupens() {
    return couponDBSource.getCoupens();
  }
}
