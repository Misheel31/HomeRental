import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/booking/presentation/view/create_booking_view.dart';
import 'package:home_rental/features/booking/presentation/widget/confirm_button.dart';
import 'package:home_rental/features/booking/presentation/widget/date_picker_field.dart';
import 'package:home_rental/features/booking/presentation/widget/guests_dropdown.dart';
import 'package:home_rental/features/booking/presentation/widget/total_price_display.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  testWidgets('CreateBookingView renders widgets and submits booking correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: const CreateBookingView(
        propertyId: '12345678',
        guestCount: 2,
      ),
      navigatorObservers: [mockObserver],
    ));

    expect(find.text('Complete your booking'), findsOneWidget);
    expect(find.byType(DatePickerField), findsNWidgets(2));
    expect(find.byType(GuestsDropdown), findsOneWidget);
    expect(find.byType(TotalPriceDisplay), findsOneWidget);
    expect(find.byType(ConfirmButton), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), '2025-02-28');
    await tester.enterText(find.byType(TextField).at(1), '2025-03-05');
    await tester.tap(find.byType(DropdownButton<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ConfirmButton));
    await tester.pumpAndSettle();
  });
}
