import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/booking/presentation/view/get_booking.dart'; // Adjust to the correct path
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    registerFallbackValue(Uri.parse(''));
  });

  testWidgets('displays bookings when fetch is successful',
      (WidgetTester tester) async {
    final mockResponse = json.encode({
      'bookings': [
        {
          '_id': '1',
        }
      ]
    });

    when(() => mockClient.get(Uri.parse(
            'http://192.168.1.70:3000/api/booking/get?username=misheel')))
        .thenAnswer((_) async => http.Response(mockResponse, 200));

    await tester.pumpWidget(const MaterialApp(
      home: GetBooking(),
    ));

    await tester.pumpAndSettle();
  });

  testWidgets('displays error message when there is an error fetching bookings',
      (WidgetTester tester) async {
    when(() => mockClient.get(Uri.parse(
            'http://192.168.1.70:3000/api/booking/get?username=misheel')))
        .thenThrow(Exception('Error fetching bookings'));

    await tester.pumpWidget(const MaterialApp(
      home: GetBooking(),
    ));

    await tester.pumpAndSettle();

    expect(find.text('No bookings found'), findsOneWidget);
  });

  testWidgets('displays "No bookings found" message when bookings are empty',
      (WidgetTester tester) async {
    final mockResponse = json.encode({'bookings': []});

    when(() => mockClient.get(Uri.parse(
            'http://192.168.1.70:3000/api/booking/get?username=misheel')))
        .thenAnswer((_) async => http.Response(mockResponse, 200));

    await tester.pumpWidget(const MaterialApp(
      home: GetBooking(),
    ));

    await tester.pumpAndSettle();

    expect(find.text('No bookings found'), findsOneWidget);
  });

  testWidgets('cancels a booking when cancel button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: GetBooking(),
    ));

    await tester.pumpAndSettle();

    final cancelBookingButton = find.text('Cancel Booking');

    expect(cancelBookingButton, findsOneWidget);

    await tester.tap(cancelBookingButton);
    await tester.pumpAndSettle();
  });

  testWidgets('shows confirmation when checkout button is pressed',
      (WidgetTester tester) async {
    final mockResponse = json.encode({
      'bookings': [
        {
          '_id': '1',
          'propertyId': 'P123',
          'startDate': '2025-02-20T00:00:00Z',
          'endDate': '2025-02-25T00:00:00Z',
          'totalPrice': 150.0
        }
      ]
    });

    when(() => mockClient.get(Uri.parse(
            'http://192.168.1.70:3000/api/booking/get?username=misheel')))
        .thenAnswer((_) async => http.Response(mockResponse, 200));

    when(() => mockClient.delete(
            Uri.parse('http://192.168.1.70:3000/api/booking/checkout/1')))
        .thenAnswer((_) async => http.Response('', 200));

    await tester.pumpWidget(const MaterialApp(
      home: GetBooking(),
    ));

    await tester.pumpAndSettle();

    expect(find.text('Checkout'), findsOneWidget);

    await tester.tap(find.text('Checkout'));
    await tester.pumpAndSettle();

    // Verify that a SnackBar is shown
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
