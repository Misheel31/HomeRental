import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:home_rental/app/constants/hive_table_constant.dart';
import 'package:home_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

//dart run build_runner build -d
part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final String username;
  @HiveField(4)
  final String password;

  AuthHiveModel(
      {String? userId,
      required this.email,
      this.image,
      required this.username,
      required this.password})
      : userId = userId ?? const Uuid().v4();

  //Initial Constructor
  const AuthHiveModel.initial()
      : userId = '',
        email = '',
        image = '',
        username = '',
        password = '';

  //From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
        userId: entity.userId,
        email: entity.email,
        image: entity.image,
        username: entity.username,
        password: entity.password);
  }

  //TO Entity
  AuthEntity toEntity() {
    return AuthEntity(
        userId: userId,
        email: email,
        image: image,
        username: username,
        password: password);
  }

  @override
  List<Object?> get props => [
    userId, email, image, username,password
  ];
}
