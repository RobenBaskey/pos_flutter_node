import 'package:pos/data/model/user_model.dart';

class IdentityModel {
  final String id;
  final String frontImage;
  final String backImage;
  final String status;
  final UserModel? user;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  IdentityModel({
    required this.id,
    required this.frontImage,
    required this.backImage,
    required this.status,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  factory IdentityModel.fromJson(Map<String, dynamic> json) {
    return IdentityModel(
      id: json['_id'] ?? "",
      frontImage: json['front_image'] ?? "",
      backImage: json['back_image'] ?? "",
      status: json['status'] ?? "",
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }
}
