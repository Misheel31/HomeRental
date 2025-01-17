import 'dart:io';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);
  
  Future<Either<Failure, String>> loginUser(
    String email, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, AuthEntity>> getCurrentUser();
}
