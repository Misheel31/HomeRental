import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';

abstract interface class IBookingDataSource {
  Future<void> createBooking(BookingEntity entity);
  Future<void> deleteBooking(String id, String? token);
  Future<List<BookingEntity>> fetchBookings(String username);
}
