import 'dart:convert';

import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:http/http.dart' as dio;
import 'package:http/http.dart' as http;

class BookingApiService {
  Future<List> fetchBookings(String username) async {
    final url = '${ApiEndpoints.baseUrl}booking/$username';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['bookings'] ?? [];
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }

  Future<dio.Response> fetchBookingDetails(String bookingId) async {
    try {
      final response = await dio.get(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.getBooking.replaceAll(':bookingId', bookingId)}'
              as Uri);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch booking details: $e');
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.deleteBooking.replaceFirst(":bookingId", bookingId)}';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to cancel booking');
      }
    } catch (e) {
      throw Exception('Error canceling booking: $e');
    }
  }

  Future<void> confirmBooking(String bookingId) async {
    final url =
        '${ApiEndpoints.baseUrl}${ApiEndpoints.confirmBooking.replaceFirst(":bookingId", bookingId)}';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Error during checkout: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error confirming booking: $e');
    }
  }
}
