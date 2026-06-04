import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/domain/entities/job_type_entity.dart';

import '../../domain/repos/job_type_repo.dart';

class JobTypeController extends GetxController {
  final JobTypeRepo _repo;
  JobTypeController(this._repo);

  var isJobTypeLoading = false.obs;
  var jobList = <JobTypeEntity>[];
  var searchJobTypeList = <JobTypeEntity>[].obs;

  final TextEditingController typeNameController = TextEditingController();
  var isActive = true.obs;
  var isAdding = false.obs;

  //edit job type
  var selectedJobType = Rxn<JobTypeEntity>();

  //delete job type
  var isDeleting = false.obs;

  @override
  void onInit() {
    getJobTypes();
    super.onInit();
  }

  Future getJobTypes({bool isLoadingActive = true}) async {
    try {
      if (isLoadingActive) isJobTypeLoading(true);
      var result = await _repo.getJobTypes();
      jobList = result;
      searchJobTypeList.value = result;
    } on Exception catch (e) {
      debugPrint("Error to get job type. Exception ${e.toString()}");
    } finally {
      if (isLoadingActive) isJobTypeLoading(false);
    }
  }

  Future addJobType() async {
    if (typeNameController.text.isEmpty) {
      Utils.showSnackBar("Please enter job type name");
      return;
    }

    isAdding(true);
    try {
      await _repo.addJobType(
        title: typeNameController.text,
        isActive: isActive.value,
      );
      typeNameController.clear();
      getJobTypes(isLoadingActive: false);
      Utils.showSnackBar(
        "Job type added successfully.",
        type: SnackBarType.success,
      );
    } on Exception catch (e) {
      debugPrint("Error to add job type.Exception ${e.toString()}");
    } finally {
      isAdding(false);
    }
  }

  void initUpdate(JobTypeEntity item) {
    selectedJobType.value = item;
    typeNameController.text = item.title ?? "";
    isActive.value = item.status == true;
  }

  Future updateJobType() async {
    if (typeNameController.text.isEmpty) {
      Utils.showSnackBar("Please enter job type name");
      return;
    }

    if (selectedJobType.value == null) {
      Utils.showSnackBar("Please select job type!");
      return;
    }

    isAdding(true);
    try {
      await _repo.updateJobType(
        id: selectedJobType.value?.id ?? "",
        title: typeNameController.text,
        isActive: isActive.value,
      );
      typeNameController.clear();
      selectedJobType.value = null;
      getJobTypes(isLoadingActive: false);
      Utils.showSnackBar(
        "Job type updated successfully.",
        type: SnackBarType.success,
      );
    } on Exception catch (e) {
      debugPrint("Error to add job type.Exception ${e.toString()}");
    } finally {
      isAdding(false);
    }
  }

  Future deleteWorkplace(String id) async {
    try {
      isDeleting(true);
      await _repo.deleteJobType(id: id);
      Get.back();
      getJobTypes(isLoadingActive: false);
    } on Exception catch (e) {
      debugPrint("Error to delete. Exception ${e.toString()}");
    } finally {
      isDeleting(false);
    }
  }

  void onSearch(String value) {
    if (value.isEmpty) {
      searchJobTypeList.value = jobList;
    } else {
      searchJobTypeList.value = jobList
          .where(
            (e) =>
                e.title?.toLowerCase().contains(value.toLowerCase()) ?? false,
          )
          .toList();
    }
  }
}
