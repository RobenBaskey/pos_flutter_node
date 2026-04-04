import 'dart:convert';

import '../../domain/entities/user_entity.dart';

class AuthResponseModel {
  final bool success;
  final String message;
  final LoginModelWithToken? loginData;

  AuthResponseModel({
    required this.success,
    required this.message,
    required this.loginData,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> data) {
    return AuthResponseModel(
      success: data["success"] ?? false,
      message: data["message"] ?? "",
      loginData: data["data"] != null
          ? LoginModelWithToken.fromJson(data["data"])
          : null,
    );
  }
}

class LoginModelWithToken {
  final UserModel? user;
  final String token;

  LoginModelWithToken({required this.user, required this.token});

  factory LoginModelWithToken.fromJson(Map<String, dynamic> data) {
    return LoginModelWithToken(
      token: data["token"] ?? "",
      user: data["user"] != null ? UserModel.fromJson(data["user"]) : null,
    );
  }
}

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.phone,
    required super.name,
    required super.role,
    required super.image,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data["id"] ?? 0,
      phone: data["phone"] ?? "",
      name: data["name"] ?? "",
      role: data["role"] ?? "",
      image: data["image"] ?? "",
      email: data["email"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "phone": phone, "email": email};
  }

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toMap());
}
