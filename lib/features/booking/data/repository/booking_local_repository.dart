import 'package:dartz/dartz.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/booking/data/data_source/local_datasource/booking_local_datasource.dart';
import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';
import 'package:home_rental/features/booking/domain/repository/booking_repository.dart';

class BookingLocalRepository implements IBookingRepository {
  final BookingLocalDatasource _bookingLocalDatasource;

  BookingLocalRepository(
      {required BookingLocalDatasource bookingLocalDatasouce})
      : _bookingLocalDatasource = bookingLocalDatasouce;

  @override
  Future<Either<Failure, void>> createBooking(BookingEntity booking) async {
    try {
      _bookingLocalDatasource.createBooking(booking);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteBooking(String id, String? token) {
    try {
      _bookingLocalDatasource.deleteBooking(id, token);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
}
