import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/coupen_db_source.dart';
import 'package:pos/data/repos/coupon_repo_impl.dart';
import 'package:pos/domain/repos/coupon_repo.dart';

import '../controller/coupon_controller.dart';

class CouponBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CouponDbSource>(() => CouponDbSourceImpl(Get.find()));
    Get.lazyPut<CouponRepo>(() => CouponRepoImpl(Get.find()));
    Get.lazyPut(() => CouponController(couponRepo: Get.find()));
  }
}
