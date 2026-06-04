import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/setting_db_source.dart';
import 'package:pos/data/repos/setting_repo_impl.dart';
import 'package:pos/domain/repos/setting_repo.dart';

import '../controller/setting_controller.dart';

class SettingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingDbSource>(() => SettingDbSourceImpl(Get.find()));
    Get.lazyPut<SettingRepo>(() => SettingRepoImpl(Get.find()));
    Get.lazyPut(() => SettingController(Get.find()));
  }
}
