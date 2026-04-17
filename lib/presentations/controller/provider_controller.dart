import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pos/domain/repos/provider_repo.dart';

import '../../data/model/user_model.dart';

class ProviderController extends GetxController {
  final ProviderRepo _providerRepo;
  ProviderController(this._providerRepo);

  var isProviderLoading = false.obs;
  var providerList = <UserModel>[].obs;

  var isCustomerLoading = false.obs;
  var customerList = <UserModel>[].obs;

  @override
  void onInit() {
    getProvider();
    getCustomers();
    super.onInit();
  }

  Future<void> getProvider() async {
    try {
      isProviderLoading.value = true;
      var response = await _providerRepo.getUsers(type: "1");
      providerList.value = response.users ?? [];
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Error", e.toString());
    } finally {
      isProviderLoading.value = false;
    }
  }

  Future<void> getCustomers() async {
    try {
      isCustomerLoading.value = true;
      var response = await _providerRepo.getUsers(type: "2");
      customerList.value = response.users ?? [];
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Error", e.toString());
    } finally {
      isCustomerLoading.value = false;
    }
  }
}
