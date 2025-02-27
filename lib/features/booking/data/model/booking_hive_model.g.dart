// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_hive_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingHiveModel _$BookingHiveModelFromJson(Map<String, dynamic> json) =>
    BookingHiveModel(
      id: json['id'] as String?,
      username: json['username'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      totalPrice: json['totalPrice'] as String,
      propertyId: json['propertyId'] as String,
    );

Map<String, dynamic> _$BookingHiveModelToJson(BookingHiveModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'totalPrice': instance.totalPrice,
      'propertyId': instance.propertyId,
    };
