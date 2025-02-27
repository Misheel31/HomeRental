import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String username;
  final String startDate;
  final String endDate;
  final String totalPrice;
  final String propertyId;

  const BookingEntity({
    required this.username,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.propertyId,
  });

  factory BookingEntity.fromJson(Map<String, dynamic> json) {
    return BookingEntity(
      propertyId: json['propertyId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      totalPrice: json['totalPrice'].toDouble(),
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propertyId': propertyId,
      'startDate': DateTime.parse(startDate).toIso8601String(),
      'endDate': DateTime.parse(endDate).toIso8601String(),
      'totalPrice': totalPrice,
    };
  }

  @override
  List<Object?> get props =>
      [username, startDate, endDate, totalPrice, propertyId];
}
