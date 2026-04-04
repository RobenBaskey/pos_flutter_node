import '../../domain/entities/job_type_entity.dart';

class JobTypeModel extends JobTypeEntity {
  JobTypeModel({
    super.id,
    super.title,
    super.status,
    super.createdAt,
    super.updatedAt,
  });

  factory JobTypeModel.fromJson(Map<String, dynamic> json) => JobTypeModel(
    id: json["_id"],
    title: json["title"],
    status: json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );
}
