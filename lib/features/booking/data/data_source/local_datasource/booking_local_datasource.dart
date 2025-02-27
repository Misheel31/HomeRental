import 'package:home_rental/core/network/hive_service.dart';
import 'package:home_rental/features/booking/data/data_source/booking_data_source.dart';
import 'package:home_rental/features/booking/data/model/booking_hive_model.dart';
import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';

class BookingLocalDatasource implements IBookingDataSource {
  final HiveService hiveService;

  BookingLocalDatasource({required this.hiveService});

  @override
  Future<void> createBooking(BookingEntity booking) async {
    try {
      final bookingHiveModel = BookingHiveModel.fromEntity(booking);
      await hiveService.createBooking(bookingHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteBooking(String id, String? token) async {
    try {
      await hiveService.deleteBooking(id as BookingHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<List<BookingEntity>> fetchBookings(String username) {
    // TODO: implement fetchBookings
    throw UnimplementedError();
  }
}
