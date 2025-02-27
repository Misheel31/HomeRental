import 'package:dartz/dartz.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';

abstract interface class IBookingRepository {
  Future<Either<Failure, void>> createBooking(BookingEntity booking);
  Future<Either<Failure, void>> deleteBooking(String id, String? token);
}
