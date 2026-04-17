import 'package:get/get.dart';

import '../../data/datasource/remote_db/package_db_source.dart';
import '../../data/repos/package_repo_impl.dart';
import '../../domain/repos/package_repo.dart';
import '../controller/package_controller.dart';

class PackageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackageDbSource>(() => PackageDbSourceImpl(Get.find()));
    Get.lazyPut<PackageRepo>(() => PackageRepoImpl(Get.find()));
    Get.lazyPut(() => PackageController(Get.find()));
  }
}
