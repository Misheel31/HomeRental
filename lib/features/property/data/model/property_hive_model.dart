import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:home_rental/app/constants/hive_table_constant.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';
import 'package:uuid/uuid.dart';

part 'property_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.propertyTableId)
class PropertyHiveModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String location;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final double pricePerNight;
  @HiveField(6)
  final bool available;
  @HiveField(7)
  final int bedCount;
  @HiveField(8)
  final int bedroomCount;
  @HiveField(9)
  final String city;
  @HiveField(10)
  final String state;
  @HiveField(11)
  final String country;
  @HiveField(12)
  final int guestCount;
  @HiveField(13)
  final int bathroomCount;
  @HiveField(14)
  final List<String> amenities;

  PropertyHiveModel({
    String? id,
    required this.title,
    required this.description,
    required this.location,
    required this.image,
    required this.pricePerNight,
    this.available = true,
    required this.bedCount,
    required this.bedroomCount,
    required this.city,
    required this.state,
    required this.country,
    required this.guestCount,
    required this.bathroomCount,
    required this.amenities,
  }) : id = id ?? const Uuid().v4();

  // Initial Constructor
  const PropertyHiveModel.initial()
      : id = '',
        title = '',
        description = '',
        location = '',
        image = '',
        pricePerNight = 0.0,
        available = true,
        bedCount = 0,
        bedroomCount = 0,
        city = '',
        state = '',
        country = '',
        guestCount = 0,
        bathroomCount = 0,
        amenities = const [];

  // From Entity
  factory PropertyHiveModel.fromEntity(PropertyEntity entity) {
    return PropertyHiveModel(
      id: entity.id,
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

  // To Entity
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

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        location,
        image,
        pricePerNight,
        available,
        bedCount,
        bedroomCount,
        city,
        state,
        country,
        guestCount,
        bathroomCount,
        amenities,
      ];
}
