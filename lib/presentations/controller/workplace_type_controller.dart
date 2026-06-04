import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/enum.dart';
import '../../core/utils/utils.dart';
import '../../domain/entities/job_type_entity.dart';
import '../../domain/repos/workplace_type_repo.dart';

class WorkplaceTypeController extends GetxController {
  final WorkplaceTypeRepo _repo;
  WorkplaceTypeController(this._repo);

  var isWorkplaceTypeLoading = false.obs;
  var workplaceList = <JobTypeEntity>[];
  var searchWorkplaceList = <JobTypeEntity>[].obs;

  final TextEditingController workplaceNameController = TextEditingController();
  var isActive = false.obs;
  var isAdding = false.obs;

  //edit job type
  var selectedWorkplaceType = Rxn<JobTypeEntity>();

  //delete workplace
  var isDeleting = false.obs;

  @override
  void onInit() {
    getWorkplaceTypes();
    super.onInit();
  }

  Future getWorkplaceTypes({bool isLoadingActive = true}) async {
    try {
      if (isLoadingActive) isWorkplaceTypeLoading(true);
      var result = await _repo.getWorkplaceTypes();
      workplaceList = result;
      searchWorkplaceList.value = result;
    } on Exception catch (e) {
      debugPrint("Error to get workplace type. Exception ${e.toString()}");
    } finally {
      if (isLoadingActive) isWorkplaceTypeLoading(false);
    }
  }

  Future addWorkplaceType() async {
    if (workplaceNameController.text.isEmpty) {
      Utils.showSnackBar("Please enter workplace type name");
      return;
    }

    isAdding(true);
    try {
      await _repo.addWorkplaceType(
        title: workplaceNameController.text,
        description: "",
        isActive: isActive.value,
      );
      workplaceNameController.clear();
      getWorkplaceTypes(isLoadingActive: false);
      Utils.showSnackBar(
        "Workplace type added successfully.",
        type: SnackBarType.success,
      );
    } on Exception catch (e) {
      debugPrint("Error to add workplace type.Exception ${e.toString()}");
    } finally {
      isAdding(false);
    }
  }

  void initUpdate(JobTypeEntity item) {
    workplaceNameController.text = item.title ?? "";
    isActive.value = item.status == true;
    selectedWorkplaceType.value = item;
  }

  Future updateJobType() async {
    if (workplaceNameController.text.isEmpty) {
      Utils.showSnackBar("Please enter workplace type name");
      return;
    }

    if (selectedWorkplaceType.value == null) {
      Utils.showSnackBar("Please select workplace type!");
      return;
    }

    isAdding(true);
    try {
      await _repo.updateWorkplaceType(
        id: selectedWorkplaceType.value?.id ?? "",
        title: workplaceNameController.text,
        isActive: isActive.value,
      );
      workplaceNameController.clear();
      selectedWorkplaceType.value = null;
      getWorkplaceTypes(isLoadingActive: false);
      Utils.showSnackBar(
        "Workplace type added successfully.",
        type: SnackBarType.success,
      );
    } on Exception catch (e) {
      debugPrint("Error to add workplace type.Exception ${e.toString()}");
    } finally {
      isAdding(false);
    }
  }

  Future deleteWorkplace(String id) async {
    try {
      isDeleting(true);
      await _repo.deleteWorkplaceType(id: id);
      Get.back();
      getWorkplaceTypes(isLoadingActive: false);
    } on Exception catch (e) {
      debugPrint("Error to delete. Exception ${e.toString()}");
    } finally {
      isDeleting(false);
    }
  }

  void onSearch(String value) {
    if (value.isEmpty) {
      searchWorkplaceList.value = workplaceList;
    } else {
      searchWorkplaceList.value = workplaceList
          .where(
            (e) =>
                e.title?.toLowerCase().contains(value.toLowerCase()) ?? false,
          )
          .toList();
    }
  }
}
