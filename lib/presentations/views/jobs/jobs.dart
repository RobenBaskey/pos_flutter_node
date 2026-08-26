import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/domain/entities/job_entity.dart';
import 'package:pos/presentations/controller/job_controller.dart';
import 'package:pos/presentations/widgets/custom_container_shape.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_string_dropdown.dart';
import '../../widgets/custom_text_field.dart';
import 'components/job_details_dialog.dart';
import 'components/job_status_badge.dart';

class JobsPage extends GetView<JobController> {
  const JobsPage({super.key});

  static const _allStatusesLabel = "All Statuses";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomContainerShape(
          padding: 0,
          child: Column(
            children: [
              _toolbar(context),
              CustomDivider(),
              Expanded(child: Obx(() => _table(context))),
              CustomDivider(),
              _pagination(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toolbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Jobs",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          SizedBox(width: 10),
          IconButton(onPressed: controller.refreshJobs, icon: Icon(Icons.refresh)),
          SizedBox(width: 10),
          SizedBox(
            width: 220,
            child: Obx(
              () => CustomStringDropdown(
                hint: _allStatusesLabel,
                selectedValue: controller.statusFilter.value?.label ?? _allStatusesLabel,
                items: [_allStatusesLabel, ...JobStatus.values.map((s) => s.label)],
                onChange: (label) {
                  if (label == null || label == _allStatusesLabel) {
                    controller.changeStatusFilter(null);
                    return;
                  }
                  final status = JobStatus.values.firstWhere((s) => s.label == label);
                  controller.changeStatusFilter(status);
                },
              ),
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 260,
            child: CustomTextField(
              hintText: "Search jobs",
              borderRadius: 8,
              borderColor: Theme.of(context).colorScheme.outline,
              onChanged: controller.searchJobs,
              suffixIcon: Icon(Icons.search, color: AppColors.greyLightTextColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _table(BuildContext context) {
    if (controller.isJobLoading.value && controller.jobList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final jobs = controller.jobList;

    if (jobs.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 40, color: AppColors.greyLightTextColor),
            SizedBox(height: 10),
            Text(
              controller.statusFilter.value != null
                  ? "No ${controller.statusFilter.value!.label.toLowerCase()} jobs found"
                  : "No jobs found",
              style: TextStyle(color: AppColors.greyLightTextColor),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        DataTable2(
          minWidth: 1100,
          dataRowHeight: 76,
          columnSpacing: 12,
          horizontalMargin: 12,
          headingTextStyle: TextStyle(
            color: AppColors.greyLightTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          dividerThickness: 0.1,
          columns: [
            DataColumn2(label: Text("JOB"), size: ColumnSize.L),
            DataColumn2(label: Text("CUSTOMER"), size: ColumnSize.M),
            DataColumn2(label: Text("SERVICE"), size: ColumnSize.M),
            DataColumn2(label: Text("BUDGET"), size: ColumnSize.S),
            DataColumn2(label: Text("STATUS"), size: ColumnSize.S),
            DataColumn2(label: Text("CREATED"), size: ColumnSize.S),
            DataColumn2(label: Text("ACTIONS"), size: ColumnSize.S),
          ],
          rows: jobs.map((job) => _buildJobRow(context, job)).toList(),
        ),
        if (controller.isJobLoading.value)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.03),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }

  DataRow _buildJobRow(BuildContext context, JobEntity job) {
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
                job.zone?.name ?? "No zone",
                style: TextStyle(fontSize: 11, color: AppColors.greyLightTextColor),
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
                style: TextStyle(fontSize: 11, color: AppColors.greyLightTextColor),
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
                job.jobCategory?.name ?? "No category",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                job.jobType?.title ?? "No type",
                style: TextStyle(fontSize: 11, color: AppColors.greyLightTextColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            Utils.formatMoney(job.cost),
            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(JobStatusBadge(status: job.status, dense: true)),
        DataCell(Text(_formatDate(job.createdAt), style: TextStyle(fontSize: 11))),
        DataCell(
          IconButton(
            tooltip: "View job",
            onPressed: job.id == null
                ? null
                : () => showJobDetailsDialog(context, controller, job.id!),
            icon: Icon(Icons.visibility_outlined, size: 18, color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _pagination() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              onPressed: controller.canGoPrevious ? controller.previousPage : null,
              icon: Icon(Icons.chevron_left),
            ),
            Text(
              "Page ${controller.currentPage.value} of ${controller.totalPages.value}",
              style: TextStyle(fontSize: 12),
            ),
            IconButton(
              onPressed: controller.canGoNext ? controller.nextPage : null,
              icon: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat("MMM dd, yyyy").format(date);
  }
}
