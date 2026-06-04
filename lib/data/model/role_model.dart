import '../../domain/entities/role_entity.dart';

class AdministratorModel {
  final String id;
  final String fullName;
  final String phone;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdministratorModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdministratorModel.fromJson(Map<String, dynamic> json) {
    return AdministratorModel(
      id: json['id'] ?? '',
      fullName: json['name'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': fullName, 'phone': phone, 'role': role};
  }

  AdministratorEntity toEntity() {
    return AdministratorEntity(
      id: id,
      fullName: fullName,
      phone: phone,
      role: role,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory AdministratorModel.fromEntity(AdministratorEntity entity) {
    return AdministratorModel(
      id: entity.id,
      fullName: entity.fullName,
      phone: entity.phone,
      role: entity.role,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
