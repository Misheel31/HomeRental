import 'dart:io';

import 'package:home_rental/core/network/hive_service.dart';
import 'package:home_rental/features/auth/data/data_source/auth_data_source.dart';
import 'package:home_rental/features/auth/data/model/auth_hive_model.dart';
import 'package:home_rental/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDatasource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDatasource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    return Future.value(const AuthEntity(
      userId: "1",
      email: "",
      image: null,
      username: "",
      password: "",
    ));
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      final user = await _hiveService.login(email, password);
      return Future.value("Login Successful");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      final authHiveModel = AuthHiveModel.fromEntity(user);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }
}
