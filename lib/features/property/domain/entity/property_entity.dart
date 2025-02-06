import 'package:equatable/equatable.dart';

class PropertyEntity extends Equatable {
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

  const PropertyEntity({
      this.id,
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
      required this.amenities,
      required this.bathroomCount,
      required this.guestCount});

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
        amenities,
        bathroomCount,
        guestCount
      ];
}
