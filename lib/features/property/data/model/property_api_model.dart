import 'package:equatable/equatable.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PropertyApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String title;
  final String description;
  final String location;
  final String image;
  final double pricePerNight;
  final bool available;
  final int bedCount;
  final int bedroomCount;
  final String city;
  final String state;
  final String country;
  final int guestCount;
  final int bathroomCount;
  final List<String> amenities;

  const PropertyApiModel({
    this.id,
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
  });

  const PropertyApiModel.empty()
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

  // From Json
  factory PropertyApiModel.fromJson(Map<String, dynamic> json) {
    return PropertyApiModel(
      id: json['_id'] ?? 'default_id',
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      location: json['location'] ?? 'Unknown location',
      image:
          (json['image'] != null && json['image'].toString().trim().isNotEmpty)
              ? Uri.encodeFull(json['image'].trim())
              : 'https://yourdefaultimage.com/default.jpg',
      pricePerNight: (json['pricePerNight'] as num?)?.toDouble() ?? 0.0,
      available: json['available'] ?? true,
      bedCount: json['bedCount'] ?? 1,
      bedroomCount: json['bedroomCount'] ?? 1,
      city: json['city'] ?? 'Unknown city',
      state: json['state'] ?? 'Unknown state',
      country: json['country'] ?? 'Unknown country',
      guestCount: json['guestCount'] ?? 1,
      bathroomCount: json['bathroomCount'] ?? 1,
      amenities: (json['amenities'] != null)
          ? List<String>.from(json['amenities'])
          : [],
    );
  }

  // To Json
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'location': location,
      'image': image,
      'pricePerNight': pricePerNight,
      'available': available,
      'bedCount': bedCount,
      'bedroomCount': bedroomCount,
      'city': city,
      'state': state,
      'country': country,
      'guestCount': guestCount,
      'bathroomCount': bathroomCount,
      'amenities': amenities,
    };
  }

  // Convert API Object to Entity
  PropertyEntity toEntity() => PropertyEntity(
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

  // Convert Entity to API Object
  static PropertyApiModel fromEntity(PropertyEntity entity) => PropertyApiModel(
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

  // Convert API List to Entity List
  static List<PropertyEntity> toEntityList(List<PropertyApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

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
