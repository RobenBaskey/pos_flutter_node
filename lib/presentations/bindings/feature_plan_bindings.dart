import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/feature_plan_db_source.dart';

import '../../data/repos/feature_plan_repo_impl.dart';
import '../../domain/repos/feature_plan_repo.dart';
import '../controller/feature_plan_controller.dart';

class FeaturePlanBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeaturePlanDbSource>(() => FeaturePlanDbSourceImpl(Get.find()));
    Get.lazyPut<FeaturePlanRepo>(() => FeaturePlanRepoImpl(Get.find()));
    Get.lazyPut<FeaturePlanController>(() => FeaturePlanController(Get.find()));
  }
}
