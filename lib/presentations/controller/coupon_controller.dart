import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/domain/entities/coupon_entity.dart';
import 'package:pos/domain/repos/coupon_repo.dart';

class CouponController extends GetxController {
  final CouponRepo couponRepo;
  CouponController({required this.couponRepo});

  var isLoading = false.obs;
  var couponList = <CouponEntity>[];
  var searchedCouponList = <CouponEntity>[].obs;

  ///add coupon
  var isCouponAdding = false.obs;
  final TextEditingController codeController = TextEditingController();
  final TextEditingController discountValueController = TextEditingController();
  final TextEditingController usageLimitController = TextEditingController();
  var isPercentage = true.obs;
  final TextEditingController minOrderValueController = TextEditingController();

  ///delete coupon
  var isCouponDeleting = false.obs;

  @override
  void onInit() {
    getCoupons();
    super.onInit();
  }

  Future<void> getCoupons() async {
    try {
      isLoading.value = true;
      final coupons = await couponRepo.getCoupens();
      couponList.assignAll(coupons);
      searchedCouponList.assignAll(coupons);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load coupons: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCoupon() async {
    if (codeController.text.isEmpty ||
        discountValueController.text.isEmpty ||
        usageLimitController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all the fields');
      return;
    }

    try {
      isCouponAdding.value = true;
      final newCoupon = CouponEntity(
        code: codeController.text,
        discountType: isPercentage.value ? "percentage" : "fixed",
        discountValue: int.tryParse(discountValueController.text) ?? 0,
        usageLimit: int.tryParse(usageLimitController.text) ?? 0,
        minOrderValue: int.tryParse(minOrderValueController.text) ?? 0,
      );
      await couponRepo.addCoupen(coupon: newCoupon);
      Utils.showSnackBar('Coupon added successfully', title: 'Success');
      getCoupons(); // Refresh the coupon list after adding
    } catch (e) {
      Get.snackbar('Error', 'Failed to add coupon: $e');
    } finally {
      isCouponAdding.value = false;
    }
  }

  void initEdit(CouponEntity coupon) {
    codeController.text = coupon.code ?? "";
    discountValueController.text = "${coupon.discountValue ?? 0}";
    isPercentage.value = coupon.discountType == "percentage";
    usageLimitController.text = "${coupon.usageLimit ?? 0}";
    minOrderValueController.text = "${coupon.minOrderValue ?? 0}";
  }

  Future<void> editCoupon(String id) async {
    if (codeController.text.isEmpty ||
        discountValueController.text.isEmpty ||
        usageLimitController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all the fields');
      return;
    }

    try {
      isCouponAdding.value = true;
      final newCoupon = CouponEntity(
        code: codeController.text,
        discountType: isPercentage.value ? "percentage" : "fixed",
        discountValue: int.tryParse(discountValueController.text) ?? 0,
        usageLimit: int.tryParse(usageLimitController.text) ?? 0,
        minOrderValue: int.tryParse(minOrderValueController.text) ?? 0,
      );
      await couponRepo.updateCoupen(id: id, coupon: newCoupon);
      Get.back();
      Utils.showSnackBar('Coupon updated successfully', title: 'Success');
      getCoupons(); // Refresh the coupon list after adding
    } catch (e) {
      Utils.showSnackBar(
        'Failed to update coupon: $e',
        title: "Error",
        type: SnackBarType.error,
        isDismissible: false,
      );
    } finally {
      isCouponAdding.value = false;
    }
  }

  Future deleteCoupon(String id) async {
    try {
      isCouponDeleting.value = true;
      var result = await couponRepo.deleteCoupen(id: id);
      Get.back();
      if (result) {
        getCoupons();
      }
    } on Exception catch (e) {
      debugPrint("Error to delete coupon. Exception ${e.toString()}");
    } finally {
      isCouponDeleting.value = false;
    }
  }

  void searchCoupon(String query) {
    if (query.isNotEmpty) {
      searchedCouponList.value = couponList
          .where(
            (e) => e.code?.toLowerCase().contains(query.toLowerCase()) ?? false,
          )
          .toList();
    } else {
      searchedCouponList.value = couponList;
    }
  }
}
