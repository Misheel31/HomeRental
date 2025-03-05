import 'package:hive_flutter/adapters.dart';
import 'package:home_rental/app/constants/hive_table_constant.dart';
import 'package:home_rental/features/auth/data/model/auth_hive_model.dart';
import 'package:home_rental/features/booking/data/model/booking_hive_model.dart';
import 'package:home_rental/features/property/data/model/property_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}home_rental.db';

    Hive.init(path);

    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(PropertyHiveModelAdapter());
  }

  Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
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
  static const String propertyBox = 'propertyBox';

  Future<Box<PropertyHiveModel>> _openBox() async {
    return await Hive.openBox<PropertyHiveModel>(propertyBox);
  }

  Future<void> createProperty(PropertyHiveModel property) async {
    var box = await _openBox();
    await box.put(property.id, property);
  }

  Future<List<PropertyHiveModel>> getAllProperties() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> deleteProperty(PropertyHiveModel property) async {
    var box = await _openBox();
    await box.delete(property.id);
  }

  Future<void> createBooking(BookingHiveModel booking) async {
    var box = await Hive.openBox(HiveTableConstant.bookingBox);
    await box.put(booking.propertyId, booking);
  }

  Future<void> deleteBooking(BookingHiveModel booking) async {
    var box = await Hive.openBox(HiveTableConstant.bookingBox);
    await box.put(booking.username, booking);
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
