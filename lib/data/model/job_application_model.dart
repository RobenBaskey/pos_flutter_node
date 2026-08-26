import 'package:pos/core/constants/enum.dart';
import 'package:pos/domain/entities/job_application_entity.dart';

import 'user_model.dart';

class JobApplicationModel extends JobApplicationEntity {
  JobApplicationModel({
    super.id,
    super.provider,
    super.expectedAmount,
    super.additionalText,
    super.status,
    super.appliedAt,
    super.updatedAt,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) =>
      JobApplicationModel(
        id: json["_id"],
        provider: json["user"] == null
            ? null
            : UserModel.fromJson(json["user"]),
        expectedAmount: (json["expected_amount"] as num?)?.toDouble(),
        additionalText: json["additional_text"],
        status: JobApplicationStatusX.fromWire(json["status"]),
        appliedAt: json["created_at"] == null || json["created_at"] == ""
            ? null
            : DateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null || json["updated_at"] == ""
            ? null
            : DateTime.tryParse(json["updated_at"]),
      );
}
