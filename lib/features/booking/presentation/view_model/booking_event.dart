part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

final class LoadBooking extends BookingEvent {}

final class AddBooking extends BookingEvent {
  final BookingEntity booking;
  const AddBooking(this.booking);

  @override
  List<Object> get props => [booking];
}
