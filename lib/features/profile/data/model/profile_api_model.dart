import 'package:home_rental/features/profile/domain/entity/user_entity.dart';

class ProfileApiModel extends UserEntity {
  const ProfileApiModel({
    required super.username,
    required super.email,
  });

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) {
    return ProfileApiModel(
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
    };
  }
}
