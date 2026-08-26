import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/model/zone_model.dart';
import 'package:pos/domain/entities/category_entity.dart';
import 'package:pos/domain/entities/job_type_entity.dart';
import 'package:pos/domain/entities/user_entity.dart';

/// Mirrors types.JobResponseModel (jono-db). `cost` is already major units —
/// the backend converts from its integer minor-unit storage before this
/// field ever reaches the API response, so it's safe to format directly
/// with Utils.formatMoney and never needs a client-side /100.
class JobEntity {
  final String? id;
  final String? title;
  final String? address;
  final LocationEntity? location;
  final bool? remotePosition;
  final double? cost;
  final String? hour;
  final String? description;
  final String? emailUrl;
  final String? video;
  final JobStatus? status;
  final String? rejectionReason;
  final String? correctionNote;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ZoneModel? zone;
  final UserEntity? user;
  final JobTypeEntity? jobType;
  final JobTypeEntity? workplace;
  final CategoryEntity? jobCategory;

  JobEntity({
    this.id,
    this.title,
    this.address,
    this.location,
    this.remotePosition,
    this.cost,
    this.hour,
    this.description,
    this.emailUrl,
    this.video,
    this.status,
    this.rejectionReason,
    this.correctionNote,
    this.createdAt,
    this.updatedAt,
    this.zone,
    this.user,
    this.jobType,
    this.workplace,
    this.jobCategory,
  });
}

class LocationEntity {
  final String? type;
  final List<double>? coordinates;

  LocationEntity({this.type, this.coordinates});
}
