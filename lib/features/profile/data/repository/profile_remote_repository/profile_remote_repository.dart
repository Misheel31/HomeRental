import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/profile/data/data_source/remote_datasource/profile_remote_datasource.dart';
import 'package:home_rental/features/profile/data/model/profile_api_model.dart';
import 'package:home_rental/features/profile/domain/entity/user_entity.dart';
import 'package:home_rental/features/profile/domain/repository/user_repository.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRemoteRepository implements IUserRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;
  final Dio _dio;
  final SharedPreferences sharedPreferences;

  ProfileRemoteRepository(
      this.profileRemoteDatasource, this._dio, this.sharedPreferences);

  @override
  Future<Either<Failure, UserEntity>> fetchUser(String username) async {
    try {
      final username = sharedPreferences.getString('username') ?? '';
      final user = await profileRemoteDatasource.fetchUser(username);
      return Right(user as UserEntity);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UserEntity user) async {
    try {
      await profileRemoteDatasource.updateUser(user);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileApiModel>> getUser() async {
    try {
      final token = sharedPreferences.getString('token') ?? '';
      final response = await _dio.get(
        ApiEndpoints.getUser,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200 && response.data != null) {
        return Right(ProfileApiModel.fromJson(response.data));
      } else {
        return const Left(ApiFailure(message: 'Failed to load profile'));
      }
    } on DioException catch (e) {
      return Left(ApiFailure(message: e.message ?? 'Error loading profile'));
    }
  }

  @override
  Future<Map<String, dynamic>> getUserProfile(String token) async {
    Map<String, dynamic> decodeToken = Jwt.parseJwt(token);
    return decodeToken;
  }
}
