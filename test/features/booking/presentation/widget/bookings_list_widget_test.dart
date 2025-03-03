import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/booking/presentation/widget/bookings_list_widgte.dart';
import 'package:mocktail/mocktail.dart';

class BuildContextFake extends Fake implements BuildContext {}

class MockCancelBooking extends Mock {
  void call(String bookingId);
}

class MockConfirmBooking extends Mock {
  void call(String bookingId, BuildContext context);
}

void main() {
  late MockCancelBooking mockCancelBooking;
  late MockConfirmBooking mockConfirmBooking;

  setUpAll(() {
    registerFallbackValue(BuildContextFake());
  });

  setUp(() {
    mockCancelBooking = MockCancelBooking();
    mockConfirmBooking = MockConfirmBooking();
  });

  group('BookingList Widget Tests', () {
    testWidgets('displays No bookings found when list is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BookingList(
                bookings: const [],
                cancelBooking: (_) {},
                checkoutBooking: (_, __) {}),
          ),
        ),
      );

      expect(find.text('No bookings found.'), findsOneWidget);
    });

    testWidgets('displays list of bookings', (WidgetTester tester) async {
      final bookings = [
        {
          '_id': '1',
          'propertyId': '101',
          'startDate': '2025-02-24T00:00:00Z',
          'endDate': '2025-02-25T00:00:00Z',
          'totalPrice': 100
        },
        {
          '_id': '2',
          'propertyId': '102',
          'startDate': '2025-03-01T00:00:00Z',
          'endDate': '2025-03-05T00:00:00Z',
          'totalPrice': 250
        },
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BookingList(
              bookings: bookings,
              cancelBooking: mockCancelBooking.call,
              checkoutBooking: mockConfirmBooking.call,
            ),
          ),
        ),
      );

      expect(find.text('Property ID: 101'), findsOneWidget);
      expect(find.text('Property ID: 102'), findsOneWidget);
      expect(find.text('Total Price: 100'), findsOneWidget);
      expect(find.text('Total Price: 250'), findsOneWidget);
    });

    testWidgets('calls cancelBooking when Cancel Booking button is tapped',
        (WidgetTester tester) async {
      final bookings = [
        {
          '_id': '1',
          'propertyId': '101',
          'startDate': '2025-02-24T00:00:00Z',
          'endDate': '2025-02-25T00:00:00Z',
          'totalPrice': 100
        },
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BookingList(
              bookings: bookings,
              cancelBooking: mockCancelBooking.call,
              checkoutBooking: mockConfirmBooking.call,
            ),
          ),
        ),
      );

      final cancelButton = find.text('Cancel Booking');
      expect(cancelButton, findsOneWidget);

      await tester.tap(cancelButton);
      await tester.pump();

      verify(() => mockCancelBooking.call('1')).called(1);
    });

    testWidgets('calls checkoutBooking when Checkout button is tapped',
        (WidgetTester tester) async {
      final bookings = [
        {
          '_id': '1',
          'propertyId': '101',
          'startDate': '2025-02-24T00:00:00Z',
          'endDate': '2025-02-25T00:00:00Z',
          'totalPrice': 100
        },
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BookingList(
              bookings: bookings,
              cancelBooking: mockCancelBooking.call,
              checkoutBooking: (bookingId, context) {
                mockConfirmBooking.call(bookingId, context);
              },
            ),
          ),
        ),
      );

      final checkoutButton = find.text('Checkout');
      expect(checkoutButton, findsOneWidget);

      await tester.tap(checkoutButton);
      await tester.pump();

      verify(() => mockConfirmBooking.call('1', any())).called(1);
    });
  });
}
