import 'package:get/get.dart';
import 'package:pos/data/model/role_model.dart';

import '../../core/constants/enum.dart';

class UserController extends GetxController {
  var users = Rxn<AdministratorModel>();
  var searchQuery = ''.obs;
  var isLoading = false.obs;

  var userType = Rxn<UserRole>();
}
