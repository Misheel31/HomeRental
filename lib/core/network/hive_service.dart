import 'package:hive_flutter/adapters.dart';
import 'package:home_rental/app/constants/hive_table_constant.dart';
import 'package:home_rental/features/auth/data/model/auth_hive_model.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';
import 'package:home_rental/features/property/data/model/property_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    //Initalizing the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}home_rental.db';

    Hive.init(path);

    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  // Future<List<AuthHiveModel>> getAllAuth() async{

  // }

  //Property Queries
  Future<void> createProperty(PropertyApiModel property) async {
    var box = await Hive.openBox(HiveTableConstant.propertyBox);
    await box.put(property.id, property);
  }

  Future<void> deleteProperty(PropertyApiModel property) async {
    var box = await Hive.openBox(HiveTableConstant.propertyBox);
    await box.put(property.id, property);
  }

Future<List<PropertyHiveModel>> getAllProperties(
    PropertyApiModel property) async {
  var box = await Hive.openBox(HiveTableConstant.propertyBox);
  return box.values.cast<PropertyHiveModel>().toList()
    ..sort((a, b) => a.title.compareTo(b.title));
}


  // Login using email and password
  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var auth = box.values.firstWhere(
        (element) => element.email == email && element.password == password,
        orElse: () => const AuthHiveModel.initial());
    return auth;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // Clear User Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
