import 'package:pos/core/constants/enum.dart';
import 'package:pos/domain/entities/user_entity.dart';

/// Mirrors types.ApplicantType (jono-db, GET .../applicants). `expectedAmount`
/// is already major units — computed server-side, see JobEntity's doc comment
/// for why no client-side conversion is needed.
class JobApplicationEntity {
  final String? id;
  final UserEntity? provider;
  final double? expectedAmount;
  final String? additionalText;
  final JobApplicationStatus? status;
  final DateTime? appliedAt;
  final DateTime? updatedAt;

  JobApplicationEntity({
    this.id,
    this.provider,
    this.expectedAmount,
    this.additionalText,
    this.status,
    this.appliedAt,
    this.updatedAt,
  });
}
