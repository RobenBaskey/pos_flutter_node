import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/model/category_model.dart';
import 'package:pos/data/model/zone_model.dart';
import 'package:pos/domain/entities/job_entity.dart';

import 'job_type_model.dart';
import 'user_model.dart';

class JobModel extends JobEntity {
  JobModel({
    super.id,
    super.title,
    super.address,
    super.location,
    super.remotePosition,
    super.cost,
    super.hour,
    super.description,
    super.emailUrl,
    super.video,
    super.status,
    super.rejectionReason,
    super.correctionNote,
    super.createdAt,
    super.updatedAt,
    super.zone,
    super.user,
    super.jobType,
    super.workplace,
    super.jobCategory,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
    id: json["_id"],
    title: json["title"],
    address: json["address"],
    location: json["location"] == null
        ? null
        : LocationModel.fromJson(json["location"]),
    remotePosition: json["remote_position"],
    cost: (json["cost"] as num?)?.toDouble(),
    hour: json["hour"],
    description: json["description"],
    emailUrl: json["email_url"],
    video: json["video"],
    status: JobStatusX.fromWire(json["status"]),
    rejectionReason: json["rejection_reason"],
    correctionNote: json["correction_note"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    zone: json["zone"] == null ? null : ZoneModel.fromJson(json["zone"]),
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
    jobType: json["job_type"] == null
        ? null
        : JobTypeModel.fromJson(json["job_type"]),
    workplace: json["workplace"] == null
        ? null
        : JobTypeModel.fromJson(json["workplace"]),
    jobCategory: json["job_category"] == null
        ? null
        : CategoryModel.fromJson(json["job_category"]),
  );
}

class LocationModel extends LocationEntity {
  LocationModel({super.type, super.coordinates});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    type: json["type"],
    coordinates: json["coordinates"] == null
        ? null
        : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
  );
}
