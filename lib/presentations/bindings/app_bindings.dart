import 'package:get/get.dart';
import 'package:pos/core/network/dio_client.dart';
import 'package:pos/core/theme/theme_controller.dart';
import 'package:pos/data/datasource/local_db/user_db_service.dart';
import 'package:pos/data/repos/user_repo_impl.dart';
import 'package:pos/domain/repos/user_repo.dart';
import 'package:pos/presentations/controller/user_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(), permanent: true);
    Get.put(DioClients(), permanent: true);
    Get.put<UserDbService>(UserDbServiceImpl(Get.find()));
    Get.put<UserRepo>(UserRepoImpl(Get.find()));
    Get.put(UserController());
  }
}
