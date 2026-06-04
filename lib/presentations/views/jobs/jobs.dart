import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos/domain/entities/job_entity.dart';
import 'package:pos/domain/entities/user_entity.dart';
import 'package:pos/presentations/controller/job_controller.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_container_shape.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_text_field.dart';

class JobsPage extends GetView<JobController> {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomContainerShape(
          padding: 0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Jobs",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: controller.refreshJobs,
                      icon: Icon(Icons.refresh),
                    ),
                    SizedBox(width: 10),
                    CustomButton(
                      onTap: () {
                        Get.snackbar(
                          "Info",
                          "Insert job is not configured yet",
                        );
                      },
                      title: "Insert Job",
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 260,
                      child: CustomTextField(
                        hintText: "Search jobs",
                        borderRadius: 8,
                        borderColor: Theme.of(context).colorScheme.outline,
                        onChanged: controller.searchJobs,
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.greyLightTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomDivider(),
              Expanded(
                child: Obx(() {
                  if (controller.isJobLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final jobs = controller.filteredJobList;

                  if (jobs.isEmpty) {
                    return Center(
                      child: Text(
                        "No jobs found",
                        style: TextStyle(color: AppColors.greyLightTextColor),
                      ),
                    );
                  }

                  return DataTable2(
                    minWidth: 1000,
                    dataRowHeight: 86,
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    headingTextStyle: TextStyle(
                      color: AppColors.greyLightTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    dividerThickness: 0.1,
                    columns: [
                      DataColumn2(label: Text("TITLE"), size: ColumnSize.L),
                      DataColumn2(label: Text("CUSTOMER"), size: ColumnSize.M),
                      DataColumn2(label: Text("DATE"), size: ColumnSize.M),
                      DataColumn2(label: Text("DETAILS"), size: ColumnSize.L),
                      DataColumn2(label: Text("COST"), size: ColumnSize.S),
                      DataColumn2(label: Text("STATUS"), size: ColumnSize.S),
                      DataColumn2(label: Text("ACTION"), size: ColumnSize.S),
                    ],
                    rows: jobs.map((job) => _buildJobRow(job)).toList(),
                  );
                }),
              ),
              CustomDivider(),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total ${controller.totalJobs.value} jobs",
                          style: TextStyle(
                            color: AppColors.greyLightTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: controller.canGoPrevious
                            ? controller.previousPage
                            : null,
                        icon: Icon(Icons.chevron_left),
                      ),
                      Text(
                        "Page ${controller.currentPage.value} of ${controller.totalPages.value}",
                        style: TextStyle(fontSize: 12),
                      ),
                      IconButton(
                        onPressed: controller.canGoNext
                            ? controller.nextPage
                            : null,
                        icon: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildJobRow(JobEntity job) {
    final customerName = [
      job.user?.firstName,
      job.user?.lastName,
    ].whereType<String>().join(' ');

    return DataRow(
      cells: [
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.title ?? "Untitled job",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                job.jobCategory?.name ?? "No category",
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.greyLightTextColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customerName.isEmpty ? "Unknown" : customerName,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                job.user?.phone ?? "",
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.greyLightTextColor,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColors.greyTextColor,
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  _formatDate(job.createdAt),
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailLine(Icons.location_pin, job.address ?? "No address"),
              SizedBox(height: 4),
              _detailLine(Icons.work_outline, job.jobType?.title ?? "No type"),
              SizedBox(height: 4),
              _detailLine(
                Icons.business_center_outlined,
                job.workplace?.title ?? "No workplace",
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            "BDT ${job.cost ?? 0}",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DataCell(_statusBadge(job.status ?? "Unknown")),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () => _showJobDetails(job),
                icon: Icon(
                  Icons.visibility_outlined,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              IconButton(
                tooltip: controller.canUpdateStatus(job)
                    ? "Review pending job"
                    : "Only pending jobs can be edited",
                onPressed: controller.canUpdateStatus(job)
                    ? () => _showStatusDialog(job)
                    : null,
                icon: Icon(
                  Icons.edit_note,
                  size: 20,
                  color: controller.canUpdateStatus(job)
                      ? AppColors.secondary
                      : AppColors.greyLightTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _detailLine(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 12, color: AppColors.greyTextColor),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 10),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(String status) {
    final color = _statusColor(status);

    return Material(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_statusIcon(status), size: 12, color: color),
            const SizedBox(width: 5),
            Text(
              status,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return Colors.green;
      case "closed":
        return Colors.blueGrey;
      case "pending":
        return Colors.orange;
      case "cancelled":
        return Colors.red;
      default:
        return AppColors.secondary;
    }
  }

  IconData _statusIcon(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return Icons.play_circle_outline;
      case "closed":
        return Icons.lock_outline;
      case "pending":
        return Icons.hourglass_top;
      case "cancelled":
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat("MMM dd, yyyy, hh:mm aa").format(date);
  }

  void _showStatusDialog(JobEntity job) {
    controller.initStatusUpdate(job);

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
                        color: Colors.orange.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.rule_folder_outlined,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Review Pending Job",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            job.title ?? "Untitled job",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.greyLightTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _statusDecisionBanner(job),
                const SizedBox(height: 16),
                if (controller.canUpdateStatus(job))
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: _statusChoiceCard(
                            title: "Active",
                            description: "Approve and publish this job.",
                            icon: Icons.play_circle_outline,
                            color: Colors.green,
                            isSelected:
                                controller.selectedStatus.value == "Active",
                            onTap: () {
                              controller.selectedStatus.value = "Active";
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _statusChoiceCard(
                            title: "Cancelled",
                            description: "Reject this job from the queue.",
                            icon: Icons.cancel_outlined,
                            color: Colors.red,
                            isSelected:
                                controller.selectedStatus.value == "Cancelled",
                            onTap: () {
                              controller.selectedStatus.value = "Cancelled";
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Text(
                    "This job is already ${job.status ?? "processed"}. Status editing is available only while a job is Pending.",
                    style: TextStyle(
                      color: AppColors.greyLightTextColor,
                      height: 1.4,
                    ),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: Get.back,
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 8),
                    Obx(
                      () => CustomButton(
                        onTap: controller.canUpdateStatus(job)
                            ? () => controller.updateJobStatus(job)
                            : Get.back,
                        title: controller.canUpdateStatus(job)
                            ? "Confirm ${controller.selectedStatus.value}"
                            : "Close",
                        isLoading: controller.isStatusUpdating.value,
                        verticalPadding: 12,
                        horizontalPadding: 20,
                        borderRadius: 8,
                        color: controller.canUpdateStatus(job)
                            ? _statusColor(controller.selectedStatus.value)
                            : AppColors.greyTextColor,
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

  Widget _statusDecisionBanner(JobEntity job) {
    final isPending = controller.canUpdateStatus(job);
    final color = isPending ? Colors.orange : _statusColor(job.status ?? "");

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_statusIcon(job.status ?? "Pending"), color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isPending
                  ? "New jobs arrive as Pending. Choose Active to approve it, or Cancelled to stop it from moving forward."
                  : "Current status is ${job.status ?? "Unknown"}. Only Pending jobs can be moved to Active or Cancelled.",
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChoiceCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: isSelected ? 0.12 : 0.04),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withValues(alpha: isSelected ? 0.8 : 0.18),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 22),
                const Spacer(),
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: color,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: AppColors.greyLightTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showJobDetails(JobEntity job) {
    final context = Get.context;
    if (context == null) return;

    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 880,
            maxHeight: MediaQuery.of(context).size.height * 0.88,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.badge_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title ?? "Untitled job",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            job.jobCategory?.name ?? "No category",
                            style: TextStyle(
                              color: AppColors.greyLightTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _statusBadge(job.status ?? "Unknown"),
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _summaryTile(
                            icon: Icons.payments_outlined,
                            label: "Cost",
                            value: "BDT ${job.cost ?? 0}",
                          ),
                          _summaryTile(
                            icon: Icons.schedule,
                            label: "Hour",
                            value: job.hour ?? "N/A",
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
                      const SizedBox(height: 18),
                      _section(
                        title: "Status Workflow",
                        child: _workflowPanel(job),
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
                            _detailItem("Email", job.emailUrl ?? "N/A"),
                            _detailItem("Video", _emptyAsNA(job.video)),
                            _detailItem("Address", job.address ?? "N/A"),
                            _detailItem(
                              "Location",
                              _formatCoordinates(job.location?.coordinates),
                            ),
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
                      _section(
                        title: "People",
                        child: Column(
                          children: [
                            _userGroup(
                              "Customer",
                              job.user,
                              Icons.person_outline,
                            ),
                            const SizedBox(height: 12),
                            _userGroup(
                              "Invited Users",
                              job.invitedUser,
                              Icons.outgoing_mail,
                            ),
                            const SizedBox(height: 12),
                            _userGroup(
                              "Applied Users",
                              job.appliedUser,
                              Icons.assignment_ind_outlined,
                            ),
                            const SizedBox(height: 12),
                            _userGroup(
                              "Accepted Users",
                              job.acceptedUser,
                              Icons.verified_user_outlined,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: Get.back, child: const Text("Close")),
                    const SizedBox(width: 8),
                    CustomButton(
                      onTap: () {
                        Get.back();
                        _showStatusDialog(job);
                      },
                      title: controller.canUpdateStatus(job)
                          ? "Review Job"
                          : "View Status",
                      verticalPadding: 12,
                      horizontalPadding: 18,
                      borderRadius: 8,
                      color: controller.canUpdateStatus(job)
                          ? AppColors.primary.withValues(alpha: 0.8)
                          : AppColors.greyTextColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

  Widget _workflowPanel(JobEntity job) {
    final currentStatus = job.status ?? "Pending";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _statusDecisionBanner(job),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: controller.statusOptions
              .map(
                (status) => _workflowStep(
                  status: status,
                  isCurrent:
                      status.toLowerCase() == currentStatus.toLowerCase(),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _workflowStep({required String status, required bool isCurrent}) {
    final color = _statusColor(status);

    return Container(
      width: 145,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isCurrent ? 0.12 : 0.035),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: isCurrent ? 0.65 : 0.12),
          width: isCurrent ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(_statusIcon(status), size: 16, color: color),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              status,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
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
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _userGroup(String title, dynamic users, IconData icon) {
    final userList = _normalizeUsers(users);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.greyTextColor),
            const SizedBox(width: 6),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(width: 6),
            Text(
              "(${userList.length})",
              style: TextStyle(
                color: AppColors.greyLightTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (userList.isEmpty)
          Text(
            "No ${title.toLowerCase()} found",
            style: TextStyle(color: AppColors.greyLightTextColor),
          )
        else
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: userList.map(_userTile).toList(),
          ),
      ],
    );
  }

  Widget _userTile(dynamic user) {
    return Container(
      width: 245,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.025),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withValues(alpha: 0.07)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            child: Text(
              _initials(_userName(user)),
              style: TextStyle(
                color: AppColors.primary,
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
                Text(
                  _userName(user),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 3),
                Text(
                  _userSubtitle(user),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.greyLightTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<dynamic> _normalizeUsers(dynamic users) {
    if (users == null) return [];
    if (users is Iterable) return users.where((user) => user != null).toList();
    return [users];
  }

  String _userName(dynamic user) {
    if (user is UserEntity) {
      final name = [
        user.firstName,
        user.lastName,
      ].whereType<String>().where((part) => part.trim().isNotEmpty).join(' ');

      if (name.isNotEmpty) return name;
      return _emptyAsNA(user.companyName ?? user.phone ?? user.id);
    }

    if (user is Map) {
      final name = [
        user['first_name'],
        user['last_name'],
      ].whereType<String>().where((part) => part.trim().isNotEmpty).join(' ');

      if (name.isNotEmpty) return name;
      return _emptyAsNA(
        user['name'] ??
            user['company_name'] ??
            user['phone'] ??
            user['_id'] ??
            user['id'],
      );
    }

    return _emptyAsNA(user?.toString());
  }

  String _userSubtitle(dynamic user) {
    if (user is UserEntity) {
      return _emptyAsNA(user.phone ?? user.companyName ?? user.address);
    }

    if (user is Map) {
      final role = _emptyAsNA(user['role']);
      final phone = _emptyAsNA(user['phone']);
      final batch = _emptyAsNA(user['batch_id']);

      return [
            role,
            phone,
            batch,
          ].where((item) => item != "N/A").join(" | ").trim().isEmpty
          ? "N/A"
          : [role, phone, batch].where((item) => item != "N/A").join(" | ");
    }

    return "N/A";
  }

  String _initials(String value) {
    final words = value
        .split(RegExp(r'\s+'))
        .where((word) => word.trim().isNotEmpty && word != "N/A")
        .toList();
    if (words.isEmpty) return "?";
    return words.take(2).map((word) => word[0].toUpperCase()).join();
  }

  String _formatCoordinates(List<double>? coordinates) {
    if (coordinates == null || coordinates.isEmpty) return "N/A";
    return coordinates.map((item) => item.toStringAsFixed(6)).join(", ");
  }

  String _emptyAsNA(dynamic value) {
    final text = value?.toString().trim() ?? "";
    return text.isEmpty ? "N/A" : text;
  }
}
