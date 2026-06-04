import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/role_db.dart';

import '../../data/repos/role_repo_impl.dart';
import '../../domain/repos/role_repo.dart';
import '../controller/role_controller.dart';

class RoleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleDb>(() => RoleDbImpl(Get.find()));
    Get.lazyPut<RoleRepo>(() => RoleRepoImpl(Get.find()));
    Get.lazyPut<RoleController>(() => RoleController(Get.find()));
  }
}
