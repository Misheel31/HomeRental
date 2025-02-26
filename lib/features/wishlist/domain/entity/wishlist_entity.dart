import 'package:equatable/equatable.dart';

class WishlistEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String image;
  final String pricePerNight;
  final String location;
  final String username;
  final String propertyId;

  const WishlistEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.pricePerNight,
    required this.location,
    required this.username,
    required this.propertyId,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        location,
        username,
        pricePerNight,
        propertyId,
        image,
        title,
      ];
}
