import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_rental/core/network/hive_service.dart';
import 'package:home_rental/features/profile/data/data_source/profile_data_source.dart';
import 'package:home_rental/features/profile/data/model/profile_hive_model.dart';
import 'package:home_rental/features/profile/domain/entity/user_entity.dart';

class ProfileLocalDatasource implements IProfileDataSource {
  final HiveService _hiveService;
  final Box<UserHiveModel> userBox;

  ProfileLocalDatasource(this._hiveService, this.userBox);

  @override
  Future<Map<String, dynamic>> fetchUser(token) async {
    return Future.value();
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    await userBox.put('user', user as UserHiveModel);
  }
  
  @override
  Future<Map<String, dynamic>> getUserProfile() {
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }


}
