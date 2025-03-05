import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/booking/presentation/widget/guests_dropdown.dart';

void main() {
  testWidgets(
      'GuestsDropdown displays correct number of guests and responds to change',
      (WidgetTester tester) async {
    int selectedGuests = 1;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GuestsDropdown(
            guests: selectedGuests,
            onChanged: (newGuests) {
              if (newGuests != null) {
                selectedGuests = newGuests;
              }
            },
          ),
        ),
      ),
    );

    expect(find.text('Guests:'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byType(DropdownButton<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('5').last);
    await tester.pumpAndSettle();
    expect(selectedGuests, 5);
  });
}
