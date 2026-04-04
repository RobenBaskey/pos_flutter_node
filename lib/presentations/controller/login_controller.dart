import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/domain/repos/auth_repo.dart';
import 'package:pos/domain/repos/user_repo.dart';

import '../routes/app_routes.dart';

class LoginController extends GetxController {
  final UserRepo _userRepo;
  final AuthRepo _authRepo;
  LoginController(this._userRepo, this._authRepo);

  final TextEditingController phoneController = TextEditingController(
    text: "01717601905",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "james555",
  );

  var isLoginLoading = false.obs;

  Future login() async {
    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
      Utils.showSnackBar("Please enter both phone number and password.");
      return;
    }

    isLoginLoading.value = true;
    try {
      final result = await _authRepo.login(
        phoneController.text,
        passwordController.text,
      );
      isLoginLoading.value = false;
      if (result != null) {
        await _userRepo.setToken(result);
        Utils.showSnackBar(
          title: "Login Success",
          "You have successfully logged in.",
          type: SnackBarType.success,
        );
        Get.toNamed(AppRoutes.mainShell);
      } else {
        Utils.showSnackBar(
          title: "Login Failed",
          "Invalid phone number or password.",
        );
      }
    } on Exception catch (e) {
      debugPrint("Login error: $e");
      isLoginLoading.value = false;
      Utils.showSnackBar(title: "Login Failed", e.toString());
    }
  }
}
