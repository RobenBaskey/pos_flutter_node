import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/dashboard_db_source.dart';
import 'package:pos/presentations/controller/dashboard_controller.dart';
import 'package:pos/presentations/controller/main_shell_controller.dart';

import '../../data/repos/dashboard_repo_impl.dart';
import '../../domain/repos/dashboard_repo.dart';

class MainShellBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainShellController());
    Get.lazyPut<DashboardDbSource>(()=> DashboardDbSourceImpl(dioClient: Get.find()));
    Get.lazyPut<DashboardRepo>(() => DashboardRepoImpl(dashboardDbSource: Get.find()));
    Get.lazyPut(() => DashboardController(Get.find()));
  }
}
