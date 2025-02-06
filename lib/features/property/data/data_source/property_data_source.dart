import 'package:home_rental/features/property/domain/entity/property_entity.dart';

abstract interface class IPropertyDataSource {
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
