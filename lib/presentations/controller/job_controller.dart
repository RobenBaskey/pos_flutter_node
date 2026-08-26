import 'dart:async';

import 'package:get/get.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/data/model/job_application_model.dart';
import 'package:pos/data/model/job_model.dart';
import 'package:pos/domain/entities/job_entity.dart';
import 'package:pos/domain/repos/job_repo.dart';

/// Admin review actions the current job status allows — backed 1:1 by the
/// atomic, conditional transitions in jono-db's database/job_review.go.
/// Never add a value here without a corresponding endpoint the backend
/// actually exposes to an admin: the frontend must only ever reflect the
/// backend's transition table, never invent one of its own.
enum JobAction { approve, requestCorrection, reject, cancel }

/// Which [JobAction]s are valid from a given status. Mirrors:
///   - approve/requestCorrection/reject: only from PendingReview
///     (ApproveJob/RequestJobCorrection/RejectJob all filter on
///     status == pending_review)
///   - cancel: PendingReview, CorrectionRequired, Approved, ProviderSelected
///     (CancelJob's cancellableFrom list)
///   - nothing: Completed, Rejected, Cancelled, Expired (terminal)
List<JobAction> allowedJobActions(JobStatus? status) {
  switch (status) {
    case JobStatus.pendingReview:
      return [
        JobAction.approve,
        JobAction.requestCorrection,
        JobAction.reject,
        JobAction.cancel,
      ];
    case JobStatus.correctionRequired:
    case JobStatus.approved:
    case JobStatus.providerSelected:
      return [JobAction.cancel];
    case JobStatus.completed:
    case JobStatus.rejected:
    case JobStatus.cancelled:
    case JobStatus.expired:
    case null:
      return const [];
  }
}

class JobController extends GetxController {
  final JobRepo _jobRepo;
  JobController(this._jobRepo);

  // ── List state ───────────────────────────────────────────────────────
  var isJobLoading = false.obs;
  var jobList = <JobModel>[].obs;
  var searchQuery = ''.obs;
  var currentPage = 1.obs;
  var perPage = 10.obs;
  var totalJobs = 0.obs;
  var totalPages = 1.obs;

  /// null = "All statuses". Defaults to the review queue so opening the
  /// page immediately surfaces what needs attention.
  var statusFilter = Rxn<JobStatus>(JobStatus.pendingReview);

  bool get canGoPrevious => currentPage.value > 1;
  bool get canGoNext => currentPage.value < totalPages.value;

  // ── Detail state ─────────────────────────────────────────────────────
  var selectedJob = Rxn<JobEntity>();
  var isDetailLoading = false.obs;

  var applicantList = <JobApplicationModel>[].obs;
  var isApplicantsLoading = false.obs;
  var totalApplicants = 0.obs;

  // ── Action state ─────────────────────────────────────────────────────
  var isApproving = false.obs;
  var isRejecting = false.obs;
  var isRequestingCorrection = false.obs;
  var isCancelling = false.obs;

  bool get isActioning =>
      isApproving.value ||
      isRejecting.value ||
      isRequestingCorrection.value ||
      isCancelling.value;

  @override
  void onInit() {
    fetchJobs();
    super.onInit();
  }

  // ── List ─────────────────────────────────────────────────────────────

  Future<void> fetchJobs({int? page}) async {
    try {
      isJobLoading.value = true;
      final response = await _jobRepo.getAllJobs(
        page: page ?? currentPage.value,
        perPage: perPage.value,
        status: statusFilter.value?.wireValue,
        search: searchQuery.value.trim().isEmpty
            ? null
            : searchQuery.value.trim(),
      );

      jobList.value = response.data;
      currentPage.value = page ?? currentPage.value;
      perPage.value = response.pagination.perPage;
      totalJobs.value = response.pagination.total;
      totalPages.value = response.pagination.totalPages == 0
          ? 1
          : response.pagination.totalPages;
    } catch (e) {
      Utils.showSnackBar(e.toString(), type: SnackBarType.error);
    } finally {
      isJobLoading.value = false;
    }
  }

  Future<void> refreshJobs() async {
    await fetchJobs(page: currentPage.value);
  }

  Future<void> nextPage() async {
    if (!canGoNext) return;
    await fetchJobs(page: currentPage.value + 1);
  }

  Future<void> previousPage() async {
    if (!canGoPrevious) return;
    await fetchJobs(page: currentPage.value - 1);
  }

  Timer? _searchDebounce;

  /// Search now queries the backend (title/description) instead of
  /// filtering an already-fetched page client-side, so it's debounced to
  /// avoid firing a request per keystroke.
  void searchJobs(String value) {
    searchQuery.value = value;
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      fetchJobs(page: 1);
    });
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    super.onClose();
  }

  void changeStatusFilter(JobStatus? status) {
    statusFilter.value = status;
    fetchJobs(page: 1);
  }

  // ── Detail ───────────────────────────────────────────────────────────

  Future<void> openJobDetails(String jobId) async {
    selectedJob.value = null;
    applicantList.clear();
    totalApplicants.value = 0;
    await Future.wait([_fetchJobDetail(jobId), _fetchApplicants(jobId)]);
  }

  Future<void> _fetchJobDetail(String jobId) async {
    try {
      isDetailLoading.value = true;
      selectedJob.value = await _jobRepo.getSingleJob(jobId);
    } catch (e) {
      Utils.showSnackBar(e.toString(), type: SnackBarType.error);
    } finally {
      isDetailLoading.value = false;
    }
  }

  Future<void> _fetchApplicants(String jobId) async {
    try {
      isApplicantsLoading.value = true;
      final response = await _jobRepo.getJobApplicants(jobId, perPage: 50);
      applicantList.value = response.data;
      totalApplicants.value = response.pagination.total;
    } catch (e) {
      Utils.showSnackBar(e.toString(), type: SnackBarType.error);
    } finally {
      isApplicantsLoading.value = false;
    }
  }

  /// Re-fetches the currently-open job's detail and applicants, and the
  /// list page behind it — called after every successful review action so
  /// neither view is left showing a stale status.
  Future<void> _refreshAfterAction(String jobId) async {
    await Future.wait([_fetchJobDetail(jobId), refreshJobs()]);
  }

  // ── Admin review actions ─────────────────────────────────────────────

  Future<void> approveJob(String jobId) async {
    try {
      isApproving.value = true;
      await _jobRepo.approveJob(jobId);
      Get.back(); // close the confirmation dialog
      await _refreshAfterAction(jobId);
      Utils.showSnackBar(
        "Job approved and is now open for provider applications.",
        isSuccess: true,
      );
    } catch (e) {
      Utils.showSnackBar(e.toString(), type: SnackBarType.error);
    } finally {
      isApproving.value = false;
    }
  }

  Future<void> rejectJob({required String jobId, required String reason}) async {
    if (reason.trim().isEmpty) {
      Utils.showSnackBar("A rejection reason is required.");
      return;
    }
    try {
      isRejecting.value = true;
      await _jobRepo.rejectJob(jobId: jobId, reason: reason.trim());
      Get.back();
      await _refreshAfterAction(jobId);
      Utils.showSnackBar("Job rejected.", isSuccess: true);
    } catch (e) {
      Utils.showSnackBar(e.toString(), type: SnackBarType.error);
    } finally {
      isRejecting.value = false;
    }
  }

  Future<void> requestJobCorrection({
    required String jobId,
    required String note,
  }) async {
    if (note.trim().isEmpty) {
      Utils.showSnackBar("A correction note is required.");
      return;
    }
    try {
      isRequestingCorrection.value = true;
      await _jobRepo.requestJobCorrection(jobId: jobId, note: note.trim());
      Get.back();
      await _refreshAfterAction(jobId);
      Utils.showSnackBar("Correction requested.", isSuccess: true);
    } catch (e) {
      Utils.showSnackBar(e.toString(), type: SnackBarType.error);
    } finally {
      isRequestingCorrection.value = false;
    }
  }

  Future<void> cancelJob(String jobId) async {
    try {
      isCancelling.value = true;
      await _jobRepo.cancelJob(jobId);
      Get.back();
      await _refreshAfterAction(jobId);
      Utils.showSnackBar("Job cancelled.", isSuccess: true);
    } catch (e) {
      Utils.showSnackBar(e.toString(), type: SnackBarType.error);
    } finally {
      isCancelling.value = false;
    }
  }
}
