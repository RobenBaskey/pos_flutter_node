import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/auth_db_source.dart';
import 'package:pos/data/repos/auth_repo_impl.dart';
import 'package:pos/domain/repos/auth_repo.dart';
import 'package:pos/presentations/controller/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthDbSource>(() => AuthDbSourceImpl(Get.find()));
    Get.lazyPut<AuthRepo>(() => AuthRepoImpl(Get.find()));
    Get.lazyPut(() => LoginController(Get.find(), Get.find()));
  }
}
