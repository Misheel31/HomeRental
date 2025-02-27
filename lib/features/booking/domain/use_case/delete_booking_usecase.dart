import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:home_rental/app/shared_prefs/token_shared_prefs.dart';
import 'package:home_rental/app/usecase/usecase.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/booking/domain/repository/booking_repository.dart';

class DeleteBookingParams extends Equatable {
  final String bookingId;

  const DeleteBookingParams({required this.bookingId});

  const DeleteBookingParams.empty() : bookingId = '_empty.String';

  @override
  List<Object?> get props => [bookingId];
}

class DeleteBookingUsecase
    implements UsecaseWithParams<void, DeleteBookingParams> {
  final IBookingRepository bookingRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteBookingUsecase({
    required this.bookingRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeleteBookingParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await bookingRepository.deleteBooking(params.bookingId, r);
    });
  }
}
