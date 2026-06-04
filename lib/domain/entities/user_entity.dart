class UserEntity {
  final String? id;
  final bool? verified;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? address;
  final String? bio;
  final String? image;
  final String? companyName;
  final int? averageRating;
  final int? ratingCount;

  UserEntity({
    this.id,
    this.verified,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.bio,
    this.image,
    this.companyName,
    this.averageRating,
    this.ratingCount,
  });
}
