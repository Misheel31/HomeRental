import 'package:equatable/equatable.dart';
import 'package:home_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String email;
  final String? image;
  @JsonKey(defaultValue: "user")
  final String role;
  final String username;
  final String? password;

  const AuthApiModel({
    this.id,
    required this.email,
    required this.image,
    this.role = 'user',
    required this.username,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      email: email,
      image: image,
      role: role,
      username: username,
      password: password ?? '', 
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      email: entity.email,
      image: entity.image,
      role: entity.role,
      username: entity.username,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props =>
      [id, email, image, role, username,password];
}