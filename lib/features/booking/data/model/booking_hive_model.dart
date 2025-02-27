import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_hive_model.g.dart';

@JsonSerializable()
class BookingHiveModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String startDate;
  @HiveField(3)
  final String endDate;
  @HiveField(4)
  final String totalPrice;
  @HiveField(5)
  final String propertyId;

  const BookingHiveModel({
    this.id,
    required this.username,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.propertyId,
  });

  const BookingHiveModel.initial()
      : id = '',
        username = '',
        startDate = '',
        endDate = '',
        totalPrice = '',
        propertyId = '';

  BookingEntity toEntity() => BookingEntity(
        username: username,
        startDate: startDate,
        endDate: endDate,
        totalPrice: totalPrice,
        propertyId: propertyId,
      );

  factory BookingHiveModel.fromEntity(BookingEntity booking) {
    return BookingHiveModel(
      username: booking.username,
      startDate: booking.startDate,
      endDate: booking.endDate,
      totalPrice: booking.totalPrice,
      propertyId: booking.propertyId,
    );
  }

  static List<BookingEntity> toEntityList(List<BookingHiveModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props =>
      [username, startDate, endDate, totalPrice, propertyId];
}
