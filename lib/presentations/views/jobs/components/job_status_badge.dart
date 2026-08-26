import 'package:flutter/material.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/theme/app_colors.dart';

/// Color/icon for every JobStatus — the single place this mapping is
/// defined, so the list table, the details header, and the workflow panel
/// can never disagree with each other about what a status looks like.
Color jobStatusColor(JobStatus? status) {
  switch (status) {
    case JobStatus.pendingReview:
      return Colors.orange;
    case JobStatus.correctionRequired:
      return Colors.amber.shade800;
    case JobStatus.approved:
      return AppColors.secondary;
    case JobStatus.providerSelected:
      return AppColors.primary;
    case JobStatus.completed:
      return Colors.green;
    case JobStatus.rejected:
      return AppColors.warningColor;
    case JobStatus.cancelled:
      return Colors.blueGrey;
    case JobStatus.expired:
      return AppColors.greyTextColor;
    case null:
      return AppColors.greyTextColor;
  }
}

IconData jobStatusIcon(JobStatus? status) {
  switch (status) {
    case JobStatus.pendingReview:
      return Icons.hourglass_top;
    case JobStatus.correctionRequired:
      return Icons.rule_folder_outlined;
    case JobStatus.approved:
      return Icons.check_circle_outline;
    case JobStatus.providerSelected:
      return Icons.person_pin_circle_outlined;
    case JobStatus.completed:
      return Icons.task_alt;
    case JobStatus.rejected:
      return Icons.cancel_outlined;
    case JobStatus.cancelled:
      return Icons.block;
    case JobStatus.expired:
      return Icons.timer_off_outlined;
    case null:
      return Icons.info_outline;
  }
}

class JobStatusBadge extends StatelessWidget {
  const JobStatusBadge({super.key, required this.status, this.dense = false});

  final JobStatus? status;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final color = jobStatusColor(status);

    return Material(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dense ? 8 : 10,
          vertical: dense ? 4 : 6,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(jobStatusIcon(status), size: dense ? 11 : 13, color: color),
            SizedBox(width: 5),
            Text(
              status?.label ?? "Unknown",
              style: TextStyle(
                fontSize: dense ? 10 : 11,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color jobApplicationStatusColor(JobApplicationStatus? status) {
  switch (status) {
    case JobApplicationStatus.pending:
      return Colors.orange;
    case JobApplicationStatus.accepted:
      return Colors.green;
    case JobApplicationStatus.rejected:
      return AppColors.warningColor;
    case JobApplicationStatus.withdrawn:
      return AppColors.greyTextColor;
    case null:
      return AppColors.greyTextColor;
  }
}

class JobApplicationStatusBadge extends StatelessWidget {
  const JobApplicationStatusBadge({super.key, required this.status});

  final JobApplicationStatus? status;

  @override
  Widget build(BuildContext context) {
    final color = jobApplicationStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status?.label ?? "Unknown",
        style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
