part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final List<BookingEntity> booking;
  final bool isLoading;
  final String? error;

  const BookingState(
      {required this.booking, required this.isLoading, this.error});

  factory BookingState.initial() {
    return const BookingState(booking: [], isLoading: false);
  }

  BookingState copyWith({
    List<BookingEntity>? booking,
    bool? isLoading,
    String? error,
  }) {
    return BookingState(
        booking: booking ?? this.booking,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [booking, isLoading, error];
}
