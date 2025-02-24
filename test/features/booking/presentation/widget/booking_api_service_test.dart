import 'dart:convert';

import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/features/booking/presentation/widget/booking_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late BookingApiService bookingApiService;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    bookingApiService = BookingApiService();
  });

  group('fetchBookings', () {
    test('should return a list of bookings when the response code is 200',
        () async {
      const username = 'testUser';
      final mockResponse = json.encode({
        'bookings': [
          {'id': '1', 'property': 'House 1', 'date': '2025-02-24'},
          {'id': '2', 'property': 'House 2', 'date': '2025-02-25'},
          {'id': '3', 'property': 'House 3', 'date': '2025-02-26'},
          {'id': '4', 'property': 'House 4', 'date': '2025-02-27'},
          {'id': '5', 'property': 'House 5', 'date': '2025-02-28'},
          {'id': '6', 'property': 'House 6', 'date': '2025-03-01'},
          {'id': '7', 'property': 'House 7', 'date': '2025-03-02'},
          {'id': '8', 'property': 'House 8', 'date': '2025-03-03'},
        ]
      });

      when(() => mockHttpClient
              .get(Uri.parse('${ApiEndpoints.baseUrl}booking/$username')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      // Act
      final result = await bookingApiService.fetchBookings(username);

      // Assert
      expect(result, isA<List>());
      expect(result.length, 8);
      expect(result[0]['property'], 'House 1');
      expect(result[1]['property'], 'House 2');
      expect(result[2]['property'], 'House 3');
      expect(result[3]['property'], 'House 4');
      expect(result[4]['property'], 'House 5');
      expect(result[5]['property'], 'House 6');
      expect(result[6]['property'], 'House 7');
      expect(result[7]['property'], 'House 8');
    });

    test('should throw an exception when the response code is not 200',
        () async {
      const username = 'testUser';

      when(() => mockHttpClient
              .get(Uri.parse('${ApiEndpoints.baseUrl}booking/$username')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() async => await bookingApiService.fetchBookings(username),
          throwsA(isA<Exception>()));
    });

    test('should throw an exception if an error occurs during the HTTP request',
        () async {
      const username = 'testUser';

      when(() => mockHttpClient
              .get(Uri.parse('${ApiEndpoints.baseUrl}booking/$username')))
          .thenThrow(Exception('Failed to load bookings'));

      expect(() async => await bookingApiService.fetchBookings(username),
          throwsA(isA<Exception>()));
    });
  });

  group('cancelBooking', () {
    test('should succeed when the cancel request returns status code 200',
        () async {
      const bookingId = '1';

      when(() => mockHttpClient.delete(Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.deleteBooking.replaceFirst(":bookingId", bookingId)}')))
          .thenAnswer((_) async => http.Response('OK', 200));

      await bookingApiService.cancelBooking(bookingId);
    });

    test('should throw an exception when the cancel request fails', () async {
      const bookingId = '1';

      when(() => mockHttpClient.delete(Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.deleteBooking.replaceFirst(":bookingId", bookingId)}')))
          .thenAnswer(
              (_) async => http.Response('Failed to cancel booking', 400));

      expect(() async => await bookingApiService.cancelBooking(bookingId),
          throwsA(isA<Exception>()));
    });

    test('should throw an exception if an error occurs during the HTTP request',
        () async {
      const bookingId = '1';

      when(() => mockHttpClient.delete(Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.deleteBooking.replaceFirst(":bookingId", bookingId)}')))
          .thenThrow(Exception('Error canceling booking'));

      expect(() async => await bookingApiService.cancelBooking(bookingId),
          throwsA(isA<Exception>()));
    });
  });
}
