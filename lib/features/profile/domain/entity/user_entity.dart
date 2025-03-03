import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? username;
  final String? email;

  const UserEntity({
    required this.username,
    required this.email,
  });

  @override
  List<Object?> get props => [username, email];

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      username: json['username'],
      email: json['email'],
    );
  }
}

class TokenEntity extends Equatable {
  final String token;
  final String id;

  const TokenEntity({required this.token, required this.id});

  @override
  List<Object?> get props => [token, id];

  factory TokenEntity.fromJson(Map<String, dynamic> json) {
    return TokenEntity(
      token: json['token'],
      id: json['_id'],
    );
  }
}
