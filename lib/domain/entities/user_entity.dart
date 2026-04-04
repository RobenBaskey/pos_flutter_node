import '../../data/model/user_model.dart';

class UserEntity {
  final int id;
  final String phone;
  final String name;
  final String image;
  final String role;
  final String email;

  UserEntity({
    required this.id,
    required this.phone,
    required this.name,
    required this.image,
    required this.role,
    required this.email,
  });

  UserModel toModel() {
    return UserModel(
      id: id,
      phone: phone,
      name: name,
      role: role,
      image: image,
      email: email,
    );
  }
}
