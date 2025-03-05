import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/booking/presentation/widget/confirm_button.dart';

void main() {
  testWidgets('ConfirmButton displays correct text and responds to tap',
      (WidgetTester tester) async {
    bool buttonPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ConfirmButton(
            isLoading: false,
            isEnabled: true,
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('Confirm Booking'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(buttonPressed, isTrue);
  });

  testWidgets('ConfirmButton is disabled when isEnabled is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ConfirmButton(
            isLoading: false,
            isEnabled: false,
            onPressed: () {},
          ),
        ),
      ),
    );

    final elevatedButton =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton));

    expect(elevatedButton.onPressed, isNull);
  });

  testWidgets('ConfirmButton shows CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ConfirmButton(
            isLoading: true,
            isEnabled: true,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    expect(find.text('Confirm Booking'), findsNothing);
  });
}
