import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/profile/data/repository/profile_remote_repository/profile_remote_repository.dart';
import 'package:home_rental/features/profile/domain/entity/user_entity.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FetchUserUsecase {
  final ProfileRemoteRepository repository;

  FetchUserUsecase(this.repository);

  Future<Either<Failure, UserEntity>> fetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final token = prefs.getString('token');

    if (username == null || username.isEmpty) {
      return const Left(ApiFailure(message: 'No username found'));
    }

    if (token == null || token.isEmpty) {
      return const Left(ApiFailure(message: 'No token found'));
    }

    try {
      final url = Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.getUser.replaceFirst(':id', username)}');
      final response = await http.get(url,
          headers: {'Authorization': 'Bearer ${prefs.getString('token')}'});

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          final user = UserEntity.fromJson(jsonResponse[0]);
          return Right(user);
        } else if (jsonResponse is Map<String, dynamic>) {
          final user = UserEntity.fromJson(jsonResponse);
          await prefs.setString('username', user.username ?? '');
          await prefs.setString('email', user.email ?? '');
          return Right(user);
        } else {
          return const Left(ApiFailure(message: 'Unexpected response format'));
        }
      } else {
        return Left(
            ApiFailure(message: "Error fetching user: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ApiFailure(message: "Error fetching user: $e"));
    }
  }

  Future<Either<Failure, void>> updateUser(UserEntity user) {
    return repository.updateUser(user);
  }

  Future<Either<Failure, UserEntity>> getUserProfile() async {
    final result = await repository.getUserProfile(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3OWM5NzFmNzc1ZmFhODU0NDFmYzk1YiIsInVzZXJuYW1lIjoibWlzaGVlbCIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzM5OTg1OTI3LCJleHAiOjE3NDAwNzIzMjd9.Eh2-XydviDa8z4rXIVOzhHDnsDO51vc1887f_8IHfko');

    if (result.containsKey('error')) {
      return Left(ApiFailure(message: result['error']));
    }

    return Right(UserEntity.fromJson(result));
  }
}
