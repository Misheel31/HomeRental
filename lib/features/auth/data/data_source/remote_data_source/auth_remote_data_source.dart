import 'dart:io';

import 'package:dio/dio.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/app/shared_prefs/token_shared_prefs.dart';
import 'package:home_rental/features/auth/data/data_source/auth_data_source.dart';
import 'package:home_rental/features/auth/data/model/auth_api_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<AuthEntity> getCurrentUser() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final userId = sharedPreferences.getString("user_id");
      if (userId == null) {
        throw Exception("User ID not found in SharedPreferences");
      }

      final tokenPrefs = TokenSharedPrefs(sharedPreferences);
      final tokenResult = await tokenPrefs.getToken();
      String? token;

      tokenResult.fold(
        (failure) {
          print("Token Error: ${failure.message}");
          token = null;
        },
        (t) => token = t,
      );

      if (token == null) {
        throw Exception("Failed to retrieve authentication token");
      }

      Response response = await _dio.get(
        "${ApiEndpoints.getUser}/$userId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("User Data Response: ${response.data}"); 

        try {
          AuthApiModel apiModel = AuthApiModel.fromJson(response.data);
          return apiModel.toEntity();
        } catch (e) {
          throw Exception("JSON Parsing Error: ${e.toString()}");
        }
      } else {
        throw Exception(
            "Failed to get current user: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            "Dio Error: ${e.response!.statusCode} - ${e.response!.data}");
      } else {
        throw Exception("Dio Error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
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
        final str = response.data['token'];
        return str;
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
