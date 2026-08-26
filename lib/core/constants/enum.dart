enum SnackBarType { error, warning, success }

enum UserRole { super_admin, admin, moderator, manager }

enum IdentityStatus { pending, verified, rejected }

/// Mirrors constant.JobStatus in the backend (constant/enum.go). Wire values
/// are snake_case, unlike the Dart enum names, so every use goes through
/// [JobStatusX.fromWire]/[JobStatusX.wireValue] rather than `.name`.
enum JobStatus {
  pendingReview,
  correctionRequired,
  approved,
  providerSelected,
  completed,
  rejected,
  cancelled,
  expired,
}

extension JobStatusX on JobStatus {
  static const _wireValues = {
    JobStatus.pendingReview: "pending_review",
    JobStatus.correctionRequired: "correction_required",
    JobStatus.approved: "approved",
    JobStatus.providerSelected: "provider_selected",
    JobStatus.completed: "completed",
    JobStatus.rejected: "rejected",
    JobStatus.cancelled: "cancelled",
    JobStatus.expired: "expired",
  };

  String get wireValue => _wireValues[this]!;

  String get label => switch (this) {
    JobStatus.pendingReview => "Pending Review",
    JobStatus.correctionRequired => "Correction Required",
    JobStatus.approved => "Approved",
    JobStatus.providerSelected => "Provider Selected",
    JobStatus.completed => "Completed",
    JobStatus.rejected => "Rejected",
    JobStatus.cancelled => "Cancelled",
    JobStatus.expired => "Expired",
  };

  static JobStatus? fromWire(String? value) {
    for (final entry in _wireValues.entries) {
      if (entry.value == value) return entry.key;
    }
    return null;
  }
}

/// Mirrors constant.JobApplicationStatus (constant/enum.go).
enum JobApplicationStatus { pending, accepted, rejected, withdrawn }

extension JobApplicationStatusX on JobApplicationStatus {
  String get wireValue => name;

  String get label => switch (this) {
    JobApplicationStatus.pending => "Pending",
    JobApplicationStatus.accepted => "Accepted",
    JobApplicationStatus.rejected => "Rejected",
    JobApplicationStatus.withdrawn => "Withdrawn",
  };

  static JobApplicationStatus? fromWire(String? value) {
    for (final status in JobApplicationStatus.values) {
      if (status.name == value) return status;
    }
    return null;
  }
}
