import 'package:get/get.dart';
import 'package:pos/presentations/controller/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
