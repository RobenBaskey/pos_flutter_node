class GeneralSettingEntity {
  final String companyName;
  final String email;
  final String phone;
  final String address;
  final String description;
  final String logo;
  final String banner;
  final bool isActive;

  const GeneralSettingEntity({
    this.companyName = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.description = '',
    this.logo = '',
    this.banner = '',
    this.isActive = true,
  });

  factory GeneralSettingEntity.fromJson(Map<String, dynamic> json) {
    return GeneralSettingEntity(
      companyName: (json['company_name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      logo: (json['logo'] ?? '').toString(),
      banner: (json['banner'] ?? '').toString(),
      isActive: json['is_active'] == true || json['is_active'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'email': email,
      'phone': phone,
      'address': address,
      'description': description,
      'logo': logo,
      'banner': banner,
      'is_active': isActive,
    };
  }
}
