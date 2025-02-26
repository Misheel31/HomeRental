// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistApiModel _$WishlistApiModelFromJson(Map<String, dynamic> json) =>
    WishlistApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      pricePerNight: json['pricePerNight'] as String,
      location: json['location'] as String,
      username: json['username'] as String,
      propertyId: json['propertyId'] as String,
    );

Map<String, dynamic> _$WishlistApiModelToJson(WishlistApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'pricePerNight': instance.pricePerNight,
      'location': instance.location,
      'username': instance.username,
      'propertyId': instance.propertyId,
    };
