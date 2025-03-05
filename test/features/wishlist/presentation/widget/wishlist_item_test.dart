import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/wishlist/presentation/widget/wishlist_item.dart';
import 'package:mocktail/mocktail.dart';

class MockOnRemove extends Mock {
  void call(String itemId);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  late MockOnRemove mockOnRemove;

  setUpAll(() {
    HttpOverrides.global = MyHttpOverrides();
  });

  setUp(() {
    mockOnRemove = MockOnRemove();
  });

  testWidgets('displays wishlist item details correctly',
      (WidgetTester tester) async {
    final item = {
      '_id': '1',
      'PropertyId': '101',
      'title': 'Luxury Apartment',
      'location': 'Downtown',
      'image': 'image.jpg'
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WishlistItem(item: item, onRemove: (_) {}),
        ),
      ),
    );

    expect(find.text('Property ID: 101'), findsOneWidget);
    expect(find.text('Property Title: Luxury Apartment'), findsOneWidget);
    expect(find.text('Location: Downtown'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('calls onRemove when remove button is pressed',
      (WidgetTester tester) async {
    final item = {
      '_id': '1',
      'PropertyId': '101',
      'title': 'Luxury Apartment',
      'location': 'Downtown',
      'image': 'image.jpg'
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WishlistItem(item: item, onRemove: mockOnRemove.call),
        ),
      ),
    );

    final removeButton = find.text('Remove from Wishlist');
    expect(removeButton, findsOneWidget);

    await tester.tap(removeButton);
    await tester.pump();

    verify(() => mockOnRemove.call('1')).called(1);
  });
}
