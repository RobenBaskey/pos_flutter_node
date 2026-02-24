import 'package:get/get.dart';
import 'package:pos/core/theme/theme_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(),permanent: true);
  }
}
