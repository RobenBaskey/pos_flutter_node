import 'package:pos/data/model/role_model.dart';

class AuthModel {
  String? token;
  int? expireAt;
  AdministratorModel? user;

  AuthModel({this.token, this.expireAt, this.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'],
      expireAt: json['expires_at'],
      user: json['data'] != null
          ? AdministratorModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'expires_at': expireAt, 'user': user?.toJson()};
  }
}
