import 'package:pos/data/model/user_model.dart';
import 'package:pos/domain/entities/user_entity.dart';

extension UserMapper on UserEntity {
  UserModel toModel() {
    return UserModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      address: address,
      bio: bio,
      image: image,
      companyName: companyName,
      averageRating: averageRating,
      ratingCount: ratingCount,
      verified: verified,
    );
  }
}
