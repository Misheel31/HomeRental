import 'package:dio/dio.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/features/booking/data/data_source/booking_data_source.dart';
import 'package:home_rental/features/booking/data/model/booking_api_model.dart';
import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';

class BookingRemoteDataSource implements IBookingDataSource {
  final Dio _dio;

  BookingRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> createBooking(BookingEntity booking) async {
    try {
      var bookingApiModel = BookingApiModel.fromEntity(booking);
      var response = await _dio.post(
        ApiEndpoints.createBooking,
        data: bookingApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteBooking(String id, String? token) async {
    try {
      var response = await _dio.delete(ApiEndpoints.deletePropertyById + id,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<BookingEntity>> fetchBookings(String username) async {
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getBooking.replaceFirst(':username', username)}';
    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      final List<dynamic> bookingsData = data['bookings'];
      return bookingsData
          .map((booking) => BookingEntity.fromJson(booking))
          .toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }
}
