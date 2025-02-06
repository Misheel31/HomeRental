import 'package:home_rental/core/network/hive_service.dart';
import 'package:home_rental/features/property/data/data_source/property_data_source.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';

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
  }) {
    try {
      return hiveService
          .getAllProperties(PropertyApiModel(
              title: title,
              description: description,
              location: location,
              image: image,
              pricePerNight: pricePerNight,
              bedCount: bedCount,
              bedroomCount: bedroomCount,
              city: city,
              state: state,
              country: country,
              guestCount: guestCount,
              bathroomCount: bathroomCount,
              amenities: amenities))
          .then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> createProperty(PropertyEntity property) {
    // TODO: implement createProperty
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProperty(String id, String? token) {
    // TODO: implement deleteProperty
    throw UnimplementedError();
  }
}
