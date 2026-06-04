import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/identity_db_source.dart';
import 'package:pos/data/repos/identity_repo_impl.dart';
import 'package:pos/domain/repos/identity_repo.dart';

import '../controller/identity_controller.dart';

class IdentityBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IdentityDbSource>(() => IdentityDbSourceImpl(Get.find()));
    Get.lazyPut<IdentityRepo>(() => IdentityRepoImpl(Get.find()));
    Get.lazyPut<IdentityController>(() => IdentityController(Get.find()));
  }
}
