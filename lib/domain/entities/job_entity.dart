import 'package:pos/domain/entities/category_entity.dart';
import 'package:pos/domain/entities/job_type_entity.dart';
import 'package:pos/domain/entities/user_entity.dart';

class JobEntity {
  final String? id;
  final String? title;
  final String? address;
  final LocationEntity? location;
  final dynamic remotePosition;
  final int? cost;
  final String? hour;
  final String? description;
  final String? emailUrl;
  final String? video;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserEntity? user;
  final JobTypeEntity? jobType;
  final JobTypeEntity? workplace;
  final CategoryEntity? jobCategory;
  final dynamic invitedUser;
  final dynamic appliedUser;
  final dynamic acceptedUser;

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
    this.createdAt,
    this.updatedAt,
    this.user,
    this.jobType,
    this.workplace,
    this.jobCategory,
    this.invitedUser,
    this.appliedUser,
    this.acceptedUser,
  });
}

class LocationEntity {
  final String? type;
  final List<double>? coordinates;

  LocationEntity({this.type, this.coordinates});
}
