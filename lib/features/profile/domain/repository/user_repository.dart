import 'package:dartz/dartz.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/profile/domain/entity/user_entity.dart';

abstract interface class IUserRepository {
  Future<Either<Failure, UserEntity>> fetchUser(String username);
  Future<Either<Failure, void>> updateUser(UserEntity user);
  Future<Map<String, dynamic>> getUserProfile(String token);
}
