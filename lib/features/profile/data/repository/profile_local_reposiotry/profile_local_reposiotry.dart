import 'package:dartz/dartz.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/profile/data/data_source/local_datasource/profile_local_datasource.dart';
import 'package:home_rental/features/profile/domain/entity/user_entity.dart';
import 'package:home_rental/features/profile/domain/repository/user_repository.dart';

class ProfileLocalReposiotry implements IUserRepository {
  final ProfileLocalDatasource _profileLocalDatasource;

  ProfileLocalReposiotry(this._profileLocalDatasource);

  @override
  Future<Either<Failure, UserEntity>> fetchUser(String username) async {
    try {
      final user = await _profileLocalDatasource.fetchUser(username);
      return Right(user as UserEntity);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UserEntity user) {
    throw UnimplementedError();
  }
  
  @override
  Future<Map<String, dynamic>> getUserProfile(String token) {
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }

  
}
