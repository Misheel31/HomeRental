import 'package:dartz/dartz.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/booking/data/data_source/remote_datasource/booking_remote_datasource.dart';
import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';
import 'package:home_rental/features/booking/domain/repository/booking_repository.dart';

class BookingRemoteRepository implements IBookingRepository {
  final BookingRemoteDataSource remoteDatasource;

  BookingRemoteRepository({required this.remoteDatasource});

  @override
  Future<Either<Failure, void>> createBooking(BookingEntity booking) async {
    try {
      remoteDatasource.createBooking(booking);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBooking(String id, String? token) async{
    try {
      remoteDatasource.deleteBooking(id, token);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
