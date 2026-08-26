import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/domain/entities/job_application_entity.dart';
import 'package:pos/domain/entities/job_entity.dart';
import 'package:pos/presentations/controller/job_controller.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_text_field.dart';

import 'job_status_badge.dart';

/// Opens the Job Details panel for [jobId] — fetches the full job document
/// (GetSingleJob, admin-authorized) and its provider applications, then
/// shows both plus the review actions the job's current status allows.
void showJobDetailsDialog(BuildContext context, JobController controller, String jobId) {
  controller.openJobDetails(jobId);

  Get.dialog(
    Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 900,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: _JobDetailsBody(controller: controller, jobId: jobId),
      ),
    ),
  );
}

class _JobDetailsBody extends StatelessWidget {
  const _JobDetailsBody({required this.controller, required this.jobId});

  final JobController controller;
  final String jobId;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isDetailLoading.value && controller.selectedJob.value == null) {
        return const SizedBox(
          height: 300,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      final job = controller.selectedJob.value;
      if (job == null) {
        return SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Job could not be loaded."),
              const SizedBox(height: 12),
              TextButton(onPressed: Get.back, child: const Text("Close")),
            ],
          ),
        );
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _header(context, job),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (job.status == JobStatus.correctionRequired &&
                      (job.correctionNote ?? "").isNotEmpty)
                    _noteBanner(
                      icon: Icons.rule_folder_outlined,
                      color: Colors.amber.shade800,
                      title: "Correction requested",
                      message: job.correctionNote!,
                    ),
                  if (job.status == JobStatus.rejected &&
                      (job.rejectionReason ?? "").isNotEmpty)
                    _noteBanner(
                      icon: Icons.cancel_outlined,
                      color: AppColors.warningColor,
                      title: "Rejection reason",
                      message: job.rejectionReason!,
                    ),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _summaryTile(
                        icon: Icons.payments_outlined,
                        label: "Budget",
                        value: Utils.formatMoney(job.cost),
                      ),
                      _summaryTile(
                        icon: Icons.category_outlined,
                        label: "Category",
                        value: job.jobCategory?.name ?? "N/A",
                      ),
                      _summaryTile(
                        icon: Icons.work_outline,
                        label: "Job Type",
                        value: job.jobType?.title ?? "N/A",
                      ),
                      _summaryTile(
                        icon: Icons.business_center_outlined,
                        label: "Workplace",
                        value: job.workplace?.title ?? "N/A",
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _section(
                    title: "Job Information",
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 10,
                      children: [
                        _detailItem("Created", _formatDate(job.createdAt)),
                        _detailItem("Updated", _formatDate(job.updatedAt)),
                        _detailItem("Hour", _emptyAsNA(job.hour)),
                        _detailItem("Zone", job.zone?.name ?? "N/A"),
                        _detailItem("Address", _emptyAsNA(job.address)),
                        _detailItem("Email / URL", _emptyAsNA(job.emailUrl)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _section(
                    title: "Description",
                    child: Text(
                      _emptyAsNA(job.description),
                      style: const TextStyle(height: 1.45),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _section(title: "Customer", child: _customerTile(job)),
                  const SizedBox(height: 14),
                  _section(
                    title:
                        "Provider Applications (${controller.totalApplicants.value})",
                    child: _applicationsList(controller),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          _actions(context, job),
        ],
      );
    });
  }

  Widget _header(BuildContext context, JobEntity job) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.badge_outlined, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.title ?? "Untitled job",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  "Job ID: ${job.id ?? "N/A"}",
                  style: TextStyle(
                    color: AppColors.greyLightTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          JobStatusBadge(status: job.status),
          IconButton(onPressed: Get.back, icon: const Icon(Icons.close)),
        ],
      ),
    );
  }

  Widget _actions(BuildContext context, JobEntity job) {
    final actions = allowedJobActions(job.status);
    final jobId = job.id;

    if (actions.isEmpty || jobId == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "No further review actions are available for a ${job.status?.label ?? "job in this"} job.",
              style: TextStyle(color: AppColors.greyLightTextColor),
            ),
            TextButton(onPressed: Get.back, child: const Text("Close")),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Obx(
        () => Wrap(
          alignment: WrapAlignment.end,
          spacing: 10,
          runSpacing: 10,
          children: [
            TextButton(onPressed: Get.back, child: const Text("Close")),
            if (actions.contains(JobAction.approve))
              CustomButton(
                onTap: controller.isActioning
                    ? () {}
                    : () => _confirmApprove(context, jobId),
                title: "Approve",
                color: Colors.green,
                verticalPadding: 12,
                horizontalPadding: 18,
                borderRadius: 8,
              ),
            if (actions.contains(JobAction.requestCorrection))
              CustomButton(
                onTap: controller.isActioning
                    ? () {}
                    : () => _showReasonDialog(
                        context,
                        title: "Request Correction",
                        description:
                            "Explain what the customer needs to fix before this job can be approved.",
                        label: "Correction Note",
                        hintText: "e.g. Please provide more information.",
                        confirmText: "Send",
                        confirmColor: Colors.amber.shade800,
                        isLoading: controller.isRequestingCorrection,
                        onConfirm: (note) => controller.requestJobCorrection(
                          jobId: jobId,
                          note: note,
                        ),
                      ),
                title: "Request Correction",
                color: Colors.amber.shade800,
                verticalPadding: 12,
                horizontalPadding: 18,
                borderRadius: 8,
              ),
            if (actions.contains(JobAction.reject))
              CustomButton(
                onTap: controller.isActioning
                    ? () {}
                    : () => _showReasonDialog(
                        context,
                        title: "Reject Job",
                        description:
                            "This permanently rejects the job before it's ever published. The customer will see this reason.",
                        label: "Rejection Reason",
                        hintText: "e.g. Duplicate listing.",
                        confirmText: "Reject",
                        confirmColor: AppColors.warningColor,
                        isLoading: controller.isRejecting,
                        onConfirm: (reason) =>
                            controller.rejectJob(jobId: jobId, reason: reason),
                      ),
                title: "Reject",
                color: AppColors.warningColor,
                verticalPadding: 12,
                horizontalPadding: 18,
                borderRadius: 8,
              ),
            if (actions.contains(JobAction.cancel))
              CustomButton(
                onTap: controller.isActioning
                    ? () {}
                    : () => _confirmCancel(context, job),
                title: "Cancel Job",
                color: AppColors.greyTextColor,
                verticalPadding: 12,
                horizontalPadding: 18,
                borderRadius: 8,
              ),
          ],
        ),
      ),
    );
  }

  void _confirmApprove(BuildContext context, String jobId) {
    Utils.showDeleteDialog(
      context,
      title: "Approve this job?",
      description:
          "After approval, providers will be able to apply with their expected amount.",
      yesButtonText: "Approve",
      isLoading: controller.isApproving,
      onYesTap: () => controller.approveJob(jobId),
    );
  }

  void _confirmCancel(BuildContext context, JobEntity job) {
    Utils.showDeleteDialog(
      context,
      title: "Cancel this job?",
      description: job.status == JobStatus.providerSelected
          ? "A provider has already been selected. Cancelling will also cancel the linked booking if it hasn't started yet."
          : "This stops the job from moving forward. This cannot be undone.",
      yesButtonText: "Cancel Job",
      isLoading: controller.isCancelling,
      onYesTap: () => controller.cancelJob(job.id!),
    );
  }

  Widget _noteBanner({
    required IconData icon,
    required Color color,
    required String title,
    required String message,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: color, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(message, style: TextStyle(color: color, height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customerTile(JobEntity job) {
    final user = job.user;
    final name = [
      user?.firstName,
      user?.lastName,
    ].whereType<String>().where((p) => p.trim().isNotEmpty).join(' ');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.025),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withValues(alpha: 0.07)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            child: Text(
              _initials(name.isEmpty ? "?" : name),
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.isEmpty ? "Unknown customer" : name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 3),
                Text(
                  _emptyAsNA(user?.phone),
                  style: TextStyle(
                    color: AppColors.greyLightTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (_emptyAsNA(user?.companyName) != "N/A")
            Text(
              user!.companyName!,
              style: TextStyle(color: AppColors.greyLightTextColor, fontSize: 12),
            ),
        ],
      ),
    );
  }

  Widget _applicationsList(JobController controller) {
    if (controller.isApplicantsLoading.value) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final applicants = controller.applicantList;
    if (applicants.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          "No providers have applied to this job yet.",
          style: TextStyle(color: AppColors.greyLightTextColor),
        ),
      );
    }

    return Column(
      children: applicants
          .map((a) => _applicantTile(a))
          .expand((w) => [w, const SizedBox(height: 8)])
          .toList()
        ..removeLast(),
    );
  }

  Widget _applicantTile(JobApplicationEntity applicant) {
    final provider = applicant.provider;
    final name = [
      provider?.firstName,
      provider?.lastName,
    ].whereType<String>().where((p) => p.trim().isNotEmpty).join(' ');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withValues(alpha: 0.07)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.secondary.withValues(alpha: 0.12),
            child: Text(
              _initials(name.isEmpty ? "?" : name),
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name.isEmpty ? "Unknown provider" : name,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    JobApplicationStatusBadge(status: applicant.status),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _emptyAsNA(provider?.phone),
                  style: TextStyle(
                    color: AppColors.greyLightTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if ((applicant.additionalText ?? "").isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    applicant.additionalText!,
                    style: const TextStyle(fontSize: 12, height: 1.3),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Utils.formatMoney(applicant.expectedAmount),
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDate(applicant.appliedAt),
                style: TextStyle(color: AppColors.greyLightTextColor, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryTile({required IconData icon, required String label, required String value}) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.greyLightTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.greyLightTextColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  String _initials(String value) {
    final words = value.split(RegExp(r'\s+')).where((w) => w.trim().isNotEmpty).toList();
    if (words.isEmpty) return "?";
    return words.take(2).map((w) => w[0].toUpperCase()).join();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat("MMM dd, yyyy, hh:mm aa").format(date);
  }

  String _emptyAsNA(dynamic value) {
    final text = value?.toString().trim() ?? "";
    return text.isEmpty ? "N/A" : text;
  }
}

/// Small form dialog for actions that require a reason/note (Reject,
/// Request Correction) — the counterpart to Utils.showDeleteDialog, which
/// only supports a plain yes/no confirmation.
void _showReasonDialog(
  BuildContext context, {
  required String title,
  required String description,
  required String label,
  required String hintText,
  required String confirmText,
  required Color confirmColor,
  required RxBool isLoading,
  required Function(String) onConfirm,
}) {
  final textController = TextEditingController();
  final errorText = "".obs;

  Get.dialog(
    Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 460,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: confirmColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.edit_note, color: confirmColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(onPressed: Get.back, icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(color: AppColors.greyLightTextColor, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "$label *",
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
              ),
              const SizedBox(height: 6),
              CustomTextField(
                hintText: hintText,
                controller: textController,
                maxLines: 3,
                borderRadius: 8,
                textColor: Colors.black87,
                borderColor: Theme.of(context).colorScheme.outline,
              ),
              Obx(
                () => errorText.value.isEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          errorText.value,
                          style: TextStyle(color: AppColors.warningColor, fontSize: 12),
                        ),
                      ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: Get.back, child: const Text("Cancel")),
                  const SizedBox(width: 8),
                  Obx(
                    () => CustomButton(
                      onTap: isLoading.value
                          ? () {}
                          : () {
                              if (textController.text.trim().isEmpty) {
                                errorText.value = "$label is required.";
                                return;
                              }
                              errorText.value = "";
                              onConfirm(textController.text.trim());
                            },
                      title: confirmText,
                      isLoading: isLoading.value,
                      color: confirmColor,
                      verticalPadding: 12,
                      horizontalPadding: 20,
                      borderRadius: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
