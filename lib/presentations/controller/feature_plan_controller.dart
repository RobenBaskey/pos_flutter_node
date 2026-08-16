import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/data/model/pagination_model.dart';
import 'package:pos/data/model/purchased_plan_model.dart';
import 'package:pos/domain/repos/feature_plan_repo.dart';

import '../../data/model/feature_plan_model.dart';

class FeaturePlanController extends GetxController {
  final FeaturePlanRepo _repo;
  FeaturePlanController(this._repo);

  var isLoading = false.obs;
  var featurePlans = <FeaturePlanModel>[].obs;

  var isFeaturePlanTabActive = true.obs;

  ///add feature plan
  var nameController = TextEditingController();
  var dayController = TextEditingController();
  var priceController = TextEditingController();
  var isActive = true.obs;
  var advantageContentController = TextEditingController();
  var advantageList = <String>[].obs;

  ///purchased plans
  var isPurchasedDataLoading = false.obs;
  var pagination = Rxn<PaginationModel>();
  var purchasedList = <PurchasedPlanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFeaturePlan();
  }

  Future<void> getFeaturePlan() async {
    try {
      isLoading.value = true;
      featurePlans.value = await _repo.getFeaturePlans();
      isLoading.value = false;
    } on Exception catch (e) {
      isLoading.value = false;
      debugPrint('Error fetching feature plans: $e');
    }
  }

  Future insertFeaturePlan() async {
    if (nameController.text.isEmpty ||
        dayController.text.isEmpty ||
        priceController.text.isEmpty) {
      Utils.showSnackBar("Please fill all the fields");
      return;
    }

    try {
      Utils.showCustomLoader();
      final featurePlan = FeaturePlanModel(
        id: "",
        name: nameController.text,
        days: int.tryParse(dayController.text) ?? 0,
        price: int.tryParse(priceController.text) ?? 0,
        status: isActive.value,
        createdAt: DateTime.now(),
        advantages: advantageList.value,
      );
      final addedPlan = await _repo.createFeaturePlan(featurePlan);
      featurePlans.add(addedPlan);
      Utils.dismissLoadingDialog();
      Get.back(); // Close the dialog after successful insertion
      clearControllers(); // Clear the controllers after successful insertion
      Utils.showSnackBar("Plan Inserted", type: SnackBarType.success);
    } on Exception catch (e) {
      Utils.dismissLoadingDialog();
      debugPrint('Error inserting feature plan: $e');
    }
  }

  void clearControllers() {
    nameController.clear();
    dayController.clear();
    priceController.clear();
    isActive.value = true;
  }

  void initUpdate(FeaturePlanModel featurePlan) {
    nameController.text = featurePlan.name;
    dayController.text = featurePlan.days.toString();
    priceController.text = featurePlan.price.toString();
    isActive.value = featurePlan.status;
    advantageList.value = featurePlan.advantages;
  }

  Future updateFeaturePlan(FeaturePlanModel featurePlan) async {
    if (nameController.text.isEmpty ||
        dayController.text.isEmpty ||
        priceController.text.isEmpty) {
      Utils.showSnackBar("Please fill all the fields");
      return;
    }

    try {
      Utils.showCustomLoader();
      final updatedPlan = FeaturePlanModel(
        id: featurePlan.id,
        name: nameController.text,
        days: int.tryParse(dayController.text) ?? 0,
        price: int.tryParse(priceController.text) ?? 0,
        status: isActive.value,
        createdAt: featurePlan.createdAt,
        advantages: advantageList.value,
      );
      final result = await _repo.updateFeaturePlan(updatedPlan);
      final index = featurePlans.indexWhere((plan) => plan.id == result.id);
      if (index != -1) {
        featurePlans[index] = result;
      }
      Utils.dismissLoadingDialog();
      Get.back(); // Close the dialog after successful update
      clearControllers(); // Clear the controllers after successful update
      Utils.showSnackBar("Plan updated", type: SnackBarType.success);
    } on Exception catch (e) {
      Utils.dismissLoadingDialog();
      debugPrint('Error updating feature plan: $e');
    }
  }

  Future deleteFeaturePlan(String featurePlanId) async {
    try {
      Utils.showCustomLoader();
      await _repo.deleteFeaturePlan(featurePlanId);
      featurePlans.removeWhere((plan) => plan.id == featurePlanId);
      Utils.dismissLoadingDialog();
      Utils.showSnackBar("Plan deleted", type: SnackBarType.success);
    } on Exception catch (e) {
      Utils.dismissLoadingDialog();
      debugPrint('Error deleting feature plan: $e');
    }
  }

  Future getPurchasedFeature() async {
    try {
      isPurchasedDataLoading(true);
      final data = await _repo.getPurchasedPlans();
      pagination.value = data.pagination;
      purchasedList.value = data.data;
      isPurchasedDataLoading(false);
    } on Exception catch (e) {
      isPurchasedDataLoading(false);
      debugPrint("Error to get purchased plan. Exception ${e.toString()}");
    }
  }

  Future updatePurchasePlanStatue() async {
    Get.back();
  }
}
