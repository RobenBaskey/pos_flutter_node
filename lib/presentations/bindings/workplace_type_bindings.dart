import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/workplace_type_source.dart';
import 'package:pos/domain/repos/workplace_type_repo.dart';
import 'package:pos/presentations/controller/workplace_type_controller.dart';

import '../../data/repos/workplace_type_repo_impl.dart';

class WorkplaceTypeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkplaceTypeSource>(() => WorkplaceTypeSourceImpl(Get.find()));
    Get.lazyPut<WorkplaceTypeRepo>(() => WorkplaceTypeRepoImpl(Get.find()));
    Get.lazyPut(() => WorkplaceTypeController(Get.find()));
  }
}
