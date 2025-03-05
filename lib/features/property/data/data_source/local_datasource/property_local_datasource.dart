import 'package:home_rental/core/network/hive_service.dart';
import 'package:home_rental/features/property/data/model/property_hive_model.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';

abstract class IPropertyDataSource {
  Future<List<PropertyEntity>> getAllProperties({
    required String title,
    required String description,
    required String location,
    required String image,
    required double pricePerNight,
    required int bedCount,
    required int bedroomCount,
    required String city,
    required String state,
    required String country,
    required int guestCount,
    required int bathroomCount,
    required List<String> amenities,
  });

  Future<void> createProperty(PropertyEntity property);

  Future<void> deleteProperty(String id, String? token);
}

class PropertyLocalDatasource implements IPropertyDataSource {
  final HiveService hiveService;

  PropertyLocalDatasource({required this.hiveService});

  @override
  Future<List<PropertyEntity>> getAllProperties({
    required String title,
    required String description,
    required String location,
    required String image,
    required double pricePerNight,
    required int bedCount,
    required int bedroomCount,
    required String city,
    required String state,
    required String country,
    required int guestCount,
    required int bathroomCount,
    required List<String> amenities,
  }) async {
    try {
      final properties = await hiveService.getAllProperties();
      return properties.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to load properties from local storage');
    }
  }

  @override
  Future<void> createProperty(PropertyEntity property) async {
    try {
      final propertyHiveModel = PropertyHiveModel.fromEntity(property);
      await hiveService.createProperty(propertyHiveModel);
    } catch (e) {
      throw Exception('Failed to create property');
    }
  }

  @override
  Future<void> deleteProperty(String id, String? token) async {
    try {
      // Assuming we are deleting by id
      // var box = await hiveService.o();
      // await box.delete(id);
    } catch (e) {
      throw Exception('Failed to delete property');
    }
  }
}
