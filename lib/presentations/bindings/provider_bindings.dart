import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/provider_db_source.dart';
import 'package:pos/data/repos/provider_repo_iml.dart';
import 'package:pos/domain/repos/provider_repo.dart';

import '../controller/provider_controller.dart';

class ProviderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderDbSource>(() => ProviderDbSourceImpl(Get.find()));
    Get.lazyPut<ProviderRepo>(() => ProviderRepoIml(Get.find()));
    Get.lazyPut<ProviderController>(() => ProviderController(Get.find()));
  }
}
