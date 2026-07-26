import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/zone_db_source.dart';
import 'package:pos/data/repos/zone_repo_impl.dart';
import 'package:pos/domain/repos/zone_repo.dart';
import 'package:pos/presentations/controller/zone_controller.dart';

class ZoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoneDbSource>(() => ZoneDbSourceImpl(Get.find()));
    Get.lazyPut<ZoneRepo>(() => ZoneRepoImpl(Get.find()));
    Get.lazyPut(() => ZoneController());
  }
}
