import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/features/property/presentation/view/property_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  testWidgets('PropertyDetailsScreen displays property details correctly',
      (WidgetTester tester) async {
    final testPropertyJson = jsonEncode({
      "id": "1",
      "title": "Test Property",
      "location": "Test Location",
      "description": "Test Description",
      "amenities": ["Wi-Fi", "Parking", "Air Conditioning"],
      "images": ["https://via.placeholder.com/150"],
      "pricePerNight": 200,
      "bedCount": 2,
      "bedroomCount": 2,
      "bathroomCount": 2,
      "guestCount": 2,
      "city": "",
      "state": "",
      "country": ""
    });

    when(() => mockClient
            .get(Uri.parse('${ApiEndpoints.baseUrl}property/properties/1')))
        .thenAnswer((_) async => http.Response(testPropertyJson, 200));

    await tester.pumpWidget(
      const MaterialApp(
        home: PropertyDetailsScreen(propertyId: '1'),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Test Property'), findsOneWidget);
    expect(find.text('Test Location'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
    expect(find.text('Wi-Fi'), findsOneWidget);
    expect(find.text('Parking'), findsOneWidget);
    expect(find.text('Air Conditioning'), findsOneWidget);
  });
}
