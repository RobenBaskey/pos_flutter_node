import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/domain/entities/category_entity.dart';
import 'package:pos/domain/entities/job_entity.dart';
import 'package:pos/domain/repos/job_repo.dart';

import '../../domain/entities/job_type_entity.dart';

class JobController extends GetxController {
  final JobRepo _jobRepo;
  JobController(this._jobRepo);

  //insert job
  var jobTitleController = TextEditingController();
  var jobDescriptionController = TextEditingController();
  var addressController = TextEditingController();
  var costController = TextEditingController();

  var isJobLoading = false.obs;
  var jobList = <JobEntity>[].obs;
  var searchQuery = ''.obs;
  var currentPage = 1.obs;
  var perPage = 10.obs;
  var totalJobs = 0.obs;
  var totalPages = 1.obs;
  var selectedStatus = ''.obs;
  var isStatusUpdating = false.obs;

  var jobTypeList = <JobTypeEntity>[].obs;
  var workplaceList = <JobTypeEntity>[].obs;
  var categoryList = <CategoryEntity>[].obs;

  final List<String> statusOptions = [
    'Pending',
    'Active',
    'Closed',
    'Cancelled',
  ];
  final List<String> pendingActionOptions = ['Active', 'Cancelled'];

  List<JobEntity> get filteredJobList {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return jobList;

    return jobList.where((job) {
      final customerName = [
        job.user?.firstName,
        job.user?.lastName,
      ].whereType<String>().join(' ');

      final searchableText = [
        job.title,
        job.address,
        job.status,
        job.jobCategory?.name,
        job.jobType?.title,
        job.workplace?.title,
        customerName,
      ].whereType<String>().join(' ').toLowerCase();

      return searchableText.contains(query);
    }).toList();
  }

  bool get canGoPrevious => currentPage.value > 1;
  bool get canGoNext => currentPage.value < totalPages.value;

  @override
  void onInit() {
    getAllJobs();
    super.onInit();
  }

  Future<void> getAllJobs({int? page}) async {
    try {
      isJobLoading.value = true;
      final response = await _jobRepo.getAllJobs(
        page: page ?? currentPage.value,
        limit: perPage.value,
      );

      jobList.value = response.items;
      currentPage.value = page ?? currentPage.value;
      perPage.value = response.perPage;
      totalJobs.value = response.total;
      totalPages.value = response.totalPages == 0 ? 1 : response.totalPages;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isJobLoading.value = false;
    }
  }

  Future<void> refreshJobs() async {
    await getAllJobs(page: currentPage.value);
  }

  Future<void> nextPage() async {
    if (!canGoNext) return;
    await getAllJobs(page: currentPage.value + 1);
  }

  Future<void> previousPage() async {
    if (!canGoPrevious) return;
    await getAllJobs(page: currentPage.value - 1);
  }

  void searchJobs(String value) {
    searchQuery.value = value;
  }

  void initStatusUpdate(JobEntity job) {
    selectedStatus.value = canUpdateStatus(job)
        ? pendingActionOptions.first
        : job.status ?? statusOptions.first;
  }

  bool canUpdateStatus(JobEntity job) {
    return job.status?.toLowerCase() == 'pending';
  }

  Future<void> updateJobStatus(JobEntity job) async {
    final id = job.id;
    if (id == null || id.isEmpty) {
      Utils.showSnackBar("Job id not found");
      return;
    }

    if (!canUpdateStatus(job)) {
      Utils.showSnackBar("Only pending jobs can be activated or cancelled.");
      return;
    }

    if (!pendingActionOptions.contains(selectedStatus.value)) {
      Utils.showSnackBar("Please select Active or Cancelled.");
      return;
    }

    try {
      isStatusUpdating.value = true;
      await _jobRepo.updateJobStatus(id: id, status: selectedStatus.value);
      Get.back();
      await getAllJobs(page: currentPage.value);
      Utils.showSnackBar(
        "Job status updated successfully.",
        type: SnackBarType.success,
      );
    } catch (e) {
      Utils.showSnackBar(e.toString(), type: SnackBarType.error);
    } finally {
      isStatusUpdating.value = false;
    }
  }

  @override
  void onClose() {
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    addressController.dispose();
    costController.dispose();
    super.onClose();
  }
}
