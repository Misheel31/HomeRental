import 'dart:io';

import 'package:dio/dio.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/features/auth/data/data_source/auth_data_source.dart';

import '../../../domain/entity/auth_entity.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(ApiEndpoints.register, data: {
        "email": user.email,
        "image": user.image,
        "role": user.role,
        "username": user.username,
        "password": user.password,
        "confirmPassword": user.password
      });

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception("Login failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'image': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];

        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
