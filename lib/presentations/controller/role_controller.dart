import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/domain/repos/role_repo.dart';

import '../../core/constants/enum.dart';
import '../../domain/entities/role_entity.dart';

class RoleController extends GetxController {
  final RoleRepo _roleRepo;
  RoleController(this._roleRepo);

  var roles = <AdministratorEntity>[].obs;
  var filterRoleList = <AdministratorEntity>[].obs;
  var isLoading = false.obs;

  ///add role
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var selectedRole = Rxn<String>();
  final roleList = ["Admin", "Moderator", "Manager"];

  @override
  void onInit() {
    super.onInit();
    fetchRoles();
  }

  Future<void> fetchRoles() async {
    try {
      isLoading.value = true;
      var result = await _roleRepo.getAllRoles();
      filterRoleList.value = result;
      roles.value = result;
    } catch (e) {
      Get.snackbar("Error", "Failed to load roles: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future saveRoles() async {
    if (fullNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        selectedRole.value == null) {
      Utils.showSnackBar("Please fill all the fields");
      return;
    }

    try {
      isLoading.value = true;
      var newRole = AdministratorEntity(
        id: '',
        fullName: fullNameController.text,
        phone: phoneController.text,
        role: selectedRole.value!.toLowerCase(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _roleRepo.addRole(newRole, passwordController.text);
      fullNameController.clear();
      phoneController.clear();
      passwordController.clear();
      selectedRole.value = null;
      Get.back();
      Utils.showSnackBar(
        "Role added successfully",
        title: "Success",
        type: SnackBarType.success,
      );
      fetchRoles();
    } catch (e) {
      Utils.showSnackBar(
        "Failed to add role: ${e.toString()}",
        title: "Error",
        type: SnackBarType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void searchRoles(String query) {
    if (query.isEmpty) {
      filterRoleList.value = roles;
    } else {
      filterRoleList.value = roles
          .where(
            (role) =>
                role.fullName.toLowerCase().contains(query.toLowerCase()) ||
                role.phone.contains(query),
          )
          .toList();
    }
  }

  Future<void> deleteRole(String id) async {
    try {
      isLoading.value = true;
      await _roleRepo.deleteRole(id);
      Get.back();
      Utils.showSnackBar(
        "Role deleted successfully",
        title: "Success",
        type: SnackBarType.success,
      );
      fetchRoles();
    } catch (e) {
      debugPrint("Failed to delete role: ${e.toString()}");
      Utils.showSnackBar(
        "Failed to delete role: ${e.toString()}",
        title: "Error",
        type: SnackBarType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
