import 'package:equatable/equatable.dart';
import 'package:home_rental/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wishlist_api_model.g.dart';

@JsonSerializable()
class WishlistApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String title;
  final String description;
  final String image;
  final String pricePerNight;
  final String location;
  final String username;
  final String propertyId;

  const WishlistApiModel({
    this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.pricePerNight,
    required this.location,
    required this.username,
    required this.propertyId,
  });

  /// Converts JSON to WishlistModel
  factory WishlistApiModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistApiModelFromJson(json);

  /// Converts WishlistModel to JSON
  Map<String, dynamic> toJson() => _$WishlistApiModelToJson(this);

  /// Converts WishlistModel to WishlistEntity
  WishlistEntity toEntity() {
    return WishlistEntity(
      id: id ?? '',
      title: title,
      description: description,
      image: image,
      pricePerNight: pricePerNight,
      location: location,
      username: username,
      propertyId: propertyId,
    );
  }

  /// Converts WishlistEntity to WishlistModel
  factory WishlistApiModel.fromEntity(WishlistEntity entity) {
    return WishlistApiModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      image: entity.image,
      pricePerNight: entity.pricePerNight,
      location: entity.location,
      username: entity.username,
      propertyId: entity.propertyId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        image,
        pricePerNight,
        location,
        username,
        propertyId,
      ];
}
