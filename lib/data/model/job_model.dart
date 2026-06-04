import 'package:pos/data/model/category_model.dart';
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
    super.createdAt,
    super.updatedAt,
    super.user,
    super.jobType,
    super.workplace,
    super.jobCategory,
    super.invitedUser,
    super.appliedUser,
    super.acceptedUser,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
    id: json["_id"],
    title: json["title"],
    address: json["address"],
    location: json["location"] == null
        ? null
        : LocationModel.fromJson(json["location"]),
    remotePosition: json["remote_position"],
    cost: json["cost"],
    hour: json["hour"],
    description: json["description"],
    emailUrl: json["email_url"],
    video: json["video"],
    status: json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
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
    invitedUser: json["invited_user"],
    appliedUser: json["applied_user"],
    acceptedUser: json["accepted_user"],
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
