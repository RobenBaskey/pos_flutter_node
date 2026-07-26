import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/banner_db_source.dart';
import 'package:pos/domain/repos/banner_repo.dart';

import '../../data/repos/banner_repo_impl.dart';
import '../controller/banner_controller.dart';

class BannerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BannerDbSource>(
      () => BannerDbSourceImpl(dioClient: Get.find()),
    );
    Get.lazyPut<BannerRepo>(() => BannerRepoImpl(bannerDbSource: Get.find()));
    Get.lazyPut(() => BannerController(bannerRepo: Get.find()));
  }
}
