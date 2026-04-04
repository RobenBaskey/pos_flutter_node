import 'package:get/get.dart';
import 'package:pos/data/datasource/remote_db/category_db_source.dart';
import 'package:pos/data/repos/category_repo_impl.dart';
import 'package:pos/domain/repos/category_repo.dart';

import '../controller/category_controller.dart';

class CategoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryDbSource>(()=> CategoryDbSourceImpl(Get.find()));
    Get.lazyPut<CategoryRepo>(() => CategoryRepoImpl(Get.find()));
    Get.lazyPut(() => CategoryController(Get.find()));
  }
}