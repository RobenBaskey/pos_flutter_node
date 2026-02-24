import 'package:get/get.dart';
import 'package:pos/presentations/controller/dashboard_controller.dart';
import 'package:pos/presentations/controller/main_shell_controller.dart';

class MainShellBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainShellController());
    Get.lazyPut(() => DashboardController());
  }
}
