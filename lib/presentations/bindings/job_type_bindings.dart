import 'package:get/get.dart';

import '../../data/datasource/remote_db/job_type_source.dart';
import '../../data/repos/job_type_repo_impl.dart';
import '../../domain/repos/job_type_repo.dart';
import '../controller/job_type_controller.dart';

class JobTypeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobTypeSource>(() => JobTypeSourceImpl(Get.find()));
    Get.lazyPut<JobTypeRepo>(() => JobTypeRepoImpl(Get.find()));
    Get.lazyPut(() => JobTypeController(Get.find()));
  }
}
