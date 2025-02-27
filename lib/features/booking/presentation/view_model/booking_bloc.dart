import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';
import 'package:home_rental/features/booking/domain/use_case/create_booking_usecase.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final CreateBookingUsecase _createBookingUsecase;

  BookingBloc({
    required CreateBookingUsecase createBookingUsecase,
  })  : _createBookingUsecase = createBookingUsecase,
        super(BookingState.initial()) {
    on<AddBooking>(_onAddBooking);
  }

  Future<void> _onAddBooking(
      AddBooking event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createBookingUsecase.call(CreateBookingParams(
      username: event.booking.username,
      startDate: event.booking.startDate,
      endDate: event.booking.endDate,
      totalPrice: event.booking.endDate,
      propertyId: event.booking.propertyId,
    ));
    result.fold(
        (failure) =>
            emit(state.copyWith(isLoading: false, error: failure.message)),
        (booking) {
      emit(state.copyWith(isLoading: false, error: null));
    });
  }
}
