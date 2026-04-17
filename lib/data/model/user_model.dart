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
    required super.verified,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.address,
    required super.bio,
    required super.image,
    required super.companyName,
    required super.averageRating,
    required super.ratingCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      verified: json["verified"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      phone: json["phone"],
      address: json["address"],
      bio: json["bio"],
      image: json["image"],
      companyName: json["company_name"],
      averageRating: json["averageRating"],
      ratingCount: json["ratingCount"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "verified": verified,
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "address": address,
      "bio": bio,
      "image": image,
      "company_name": companyName,
      "averageRating": averageRating,
      "ratingCount": ratingCount,
    };
  }

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toMap());
}

class DataPaginationModel<T> {
  final int? lastPage;
  final int? perPage;
  final int? total;
  final int? totalPage;
  final List<T>? users;

  DataPaginationModel({
    this.lastPage,
    this.perPage,
    this.total,
    this.totalPage,
    this.users,
  });

  DataPaginationModel copyWith({
    int? lastPage,
    int? perPage,
    int? total,
    int? totalPage,
    List<T>? users,
  }) => DataPaginationModel(
    lastPage: lastPage ?? this.lastPage,
    perPage: perPage ?? this.perPage,
    total: total ?? this.total,
    totalPage: totalPage ?? this.totalPage,
    users: users ?? this.users,
  );

  factory DataPaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) => DataPaginationModel(
    lastPage: json["last_page"],
    perPage: json["per_page"],
    total: json["total"],
    totalPage: json["total_page"],
    users: json["users"] == null
        ? []
        : List<T>.from(json["users"].map((x) => fromJsonT(x))),
  );
}
