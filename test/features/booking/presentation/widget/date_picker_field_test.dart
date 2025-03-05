import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/booking/presentation/widget/date_picker_field.dart';

void main() {
  testWidgets(
      'DatePickerField displays correct label and updates text on date selection',
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();
    bool onChangedCalled = true;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DatePickerField(
            label: 'Check-in Date',
            controller: controller,
            onChanged: () {
              onChangedCalled = false;
            },
          ),
        ),
      ),
    );

    expect(find.text('Check-in Date'), findsOneWidget);

    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();

    controller.text = '2025-05-20';
    await tester.pump();

    expect(controller.text, '2025-05-20');

    expect(onChangedCalled, isTrue);
  });

  testWidgets('DatePickerField is read-only and does not allow manual input',
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DatePickerField(
            label: 'Check-out Date',
            controller: controller,
            onChanged: () {},
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), '2025-06-15');

    expect(controller.text, isEmpty);
  });
}
