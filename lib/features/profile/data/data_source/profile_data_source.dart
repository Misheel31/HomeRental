import 'package:home_rental/features/profile/domain/entity/user_entity.dart';

abstract interface class IProfileDataSource {
  Future<Map<String, dynamic>> fetchUser(String token);
  Future<void> updateUser(UserEntity user);
  Future<Map<String, dynamic>> getUserProfile();
}
