import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/job_db_source.dart';
import 'package:pos/data/repos/job_repo_impl.dart';
import 'package:pos/domain/repos/job_repo.dart';
import 'package:pos/presentations/controller/job_controller.dart';

class JobBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobDbSource>(() => JobDbSourceImpl(Get.find()));
    Get.lazyPut<JobRepo>(() => JobRepoImpl(Get.find()));
    Get.lazyPut<JobController>(() => JobController(Get.find()));
  }
}
