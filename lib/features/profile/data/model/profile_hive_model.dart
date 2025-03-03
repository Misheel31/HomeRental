import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:home_rental/app/constants/hive_table_constant.dart';
import 'package:home_rental/features/profile/domain/entity/user_entity.dart';

part 'profile_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String email;

  const UserHiveModel({
    required this.username,
    required this.email,
  });

  factory UserHiveModel.fromEntity(UserEntity user) {
    return UserHiveModel(
      username: user.username?? '',
      email: user.email?? '',
    );
  }

  @override
  List<Object?> get props => [username, email];
}
