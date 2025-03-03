import 'package:dio/dio.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/features/profile/data/data_source/profile_data_source.dart';
import 'package:home_rental/features/profile/data/model/profile_api_model.dart';
import 'package:home_rental/features/profile/domain/entity/user_entity.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRemoteDatasource implements IProfileDataSource {
  final Dio _dio;
  final SharedPreferences sharedPreferences;

  ProfileRemoteDatasource(this._dio, this.sharedPreferences);

  @override
  // Future<UserEntity> fetchUser(String username) async {
  //   try {
  //     String url = ApiEndpoints.getUser.replaceFirst(":id", username);

  //     Response<Map<String, dynamic>> response =
  //         await _dio.get<Map<String, dynamic>>(url);

  //     print("Response data: ${response.data}");
  //     if (response.statusCode == 200 && response.data != null) {
  //       return ProfileApiModel.fromJson(response.data!);
  //     } else {
  //       throw Exception("Failed to fetch user");
  //     }
  //   } on DioException catch (e) {
  //     throw Exception('Error fetching user: ${e.message}');
  //   }
  // }

  Future<Map<String, dynamic>> fetchUser(String token) async {
    Map<String, dynamic> decodeToken = Jwt.parseJwt(token);
    return decodeToken;
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    try {
      String url =
          ApiEndpoints.updateUser.replaceFirst(":id", user.username ?? '');
      Response response = await _dio.put(url, data: {
        "username": user.username,
        "email": user.email,
      });

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            "Failed to update user, status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception('Error updating user: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final token = sharedPreferences.getString('token') ?? '';
      final response = await _dio.get(
        ApiEndpoints.getUser,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200 && response.data != null) {
        final profile = ProfileApiModel.fromJson(response.data);
        return profile.toJson();
      } else {
        throw Exception('Failed to load profile');
      }
    } on DioException catch (e) {
      throw Exception('Error loading profile: ${e.message}');
    }
  }
}
