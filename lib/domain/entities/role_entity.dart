class AdministratorEntity {
  final String id;
  final String fullName;
  final String phone;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdministratorEntity({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });
}
