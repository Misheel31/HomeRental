import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:home_rental/app/usecase/usecase.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';
import 'package:home_rental/features/booking/domain/repository/booking_repository.dart';

class CreateBookingParams extends Equatable {
  final String username;
  final String startDate;
  final String endDate;
  final String totalPrice;
  final String propertyId;

  const CreateBookingParams({
    required this.username,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.propertyId,
  });

  @override
  List<Object?> get props =>
      [username, startDate, endDate, totalPrice, propertyId];
}

class CreateBookingUsecase
    implements UsecaseWithParams<void, CreateBookingParams> {
  final IBookingRepository bookingRepository;

  CreateBookingUsecase({required this.bookingRepository});

  @override
  Future<Either<Failure, void>> call(CreateBookingParams params) async {
    return await bookingRepository.createBooking(BookingEntity(
      username: params.username,
      startDate: params.startDate,
      endDate: params.endDate,
      totalPrice: params.totalPrice,
      propertyId: params.propertyId,
    ));
  }
}
