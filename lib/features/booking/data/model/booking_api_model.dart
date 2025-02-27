import 'package:equatable/equatable.dart';
import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BookingApiModel extends Equatable {
  final String username;
  final String startDate;
  final String endDate;
  final String totalPrice;
  final String propertyId;

  const BookingApiModel({
    required this.username,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.propertyId,
  });

  const BookingApiModel.empty()
      : username = '',
        startDate = '',
        endDate = '',
        totalPrice = '',
        propertyId = '';

  factory BookingApiModel.fromJson(Map<String, dynamic> json) {
    return BookingApiModel(
      username: json['username'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      totalPrice: json['totalPrice'],
      propertyId: json['propertyId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'startDate': startDate,
      'endDate': endDate,
      'totalPrice': totalPrice,
      'propertyId': propertyId,
    };
  }

  BookingEntity toEntity() => BookingEntity(
        username: username,
        startDate: startDate,
        endDate: endDate,
        totalPrice: totalPrice,
        propertyId: propertyId,
      );

  static BookingApiModel fromEntity(BookingEntity booking) {
    return BookingApiModel(
      username: booking.username,
      startDate: booking.startDate,
      endDate: booking.endDate,
      totalPrice: booking.totalPrice,
      propertyId: booking.propertyId,
    );
  }

  static List<BookingEntity> toEntityList(List<BookingApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props =>
      [username, startDate, endDate, totalPrice, propertyId];
}
