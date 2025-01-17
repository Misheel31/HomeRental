import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:home_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:home_rental/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDatasource _authLocalDatasource;

  AuthLocalRepository(this._authLocalDatasource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final currentUser = await _authLocalDatasource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(String email, String password) async {
    try {
      final token = await _authLocalDatasource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      return Right(_authLocalDatasource.registerUser(user));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(file) {
    throw UnimplementedError();
  }
}
