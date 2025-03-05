import 'package:hive_flutter/adapters.dart';
import 'package:home_rental/app/constants/hive_table_constant.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';

part 'property_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.propertyTableId)
@HiveType(typeId: 1)
class PropertyHiveModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String location;
  @HiveField(4)
  String image;
  @HiveField(5)
  double pricePerNight;
  @HiveField(6)
  bool available;
  @HiveField(7)
  int bedCount;
  @HiveField(8)
  int bedroomCount;
  @HiveField(9)
  String city;
  @HiveField(10)
  String state;
  @HiveField(11)
  String country;
  @HiveField(12)
  int guestCount;
  @HiveField(13)
  int bathroomCount;
  @HiveField(14)
  List<String> amenities;

  PropertyHiveModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.image,
    required this.pricePerNight,
    required this.available,
    required this.bedCount,
    required this.bedroomCount,
    required this.city,
    required this.state,
    required this.country,
    required this.guestCount,
    required this.bathroomCount,
    required this.amenities,
  });

  factory PropertyHiveModel.fromEntity(PropertyEntity entity) {
    return PropertyHiveModel(
      id: entity.id ?? '',
      title: entity.title,
      description: entity.description,
      location: entity.location,
      image: entity.image,
      pricePerNight: entity.pricePerNight,
      available: entity.available,
      bedCount: entity.bedCount,
      bedroomCount: entity.bedroomCount,
      city: entity.city,
      state: entity.state,
      country: entity.country,
      guestCount: entity.guestCount,
      bathroomCount: entity.bathroomCount,
      amenities: entity.amenities,
    );
  }

  PropertyEntity toEntity() {
    return PropertyEntity(
      id: id,
      title: title,
      description: description,
      location: location,
      image: image,
      pricePerNight: pricePerNight,
      available: available,
      bedCount: bedCount,
      bedroomCount: bedroomCount,
      city: city,
      state: state,
      country: country,
      guestCount: guestCount,
      bathroomCount: bathroomCount,
      amenities: amenities,
    );
  }
}
