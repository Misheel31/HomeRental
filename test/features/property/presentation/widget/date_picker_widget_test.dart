import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/property/presentation/widget/date_picker_widget.dart';

void main() {
  group('DatePickerWidget Tests', () {
    testWidgets('Renders DatePickerWidget', (WidgetTester tester) async {
      // Arrange
      DateTime selectedDate = DateTime(2024, 3, 5);
      void onDateChange(DateTime date) {
        selectedDate = date;
      }

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DatePickerWidget(
              selectedDate: selectedDate,
              onDateChange: onDateChange,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(DatePicker), findsOneWidget);
    });

    testWidgets('Updates selected date on user interaction',
        (WidgetTester tester) async {
      // Arrange
      DateTime selectedDate = DateTime(2024, 3, 5);
      void onDateChange(DateTime date) {
        selectedDate = date;
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DatePickerWidget(
              selectedDate: selectedDate,
              onDateChange: onDateChange,
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(DatePicker));

      // Assert
      expect(selectedDate, isNot(DateTime(2024, 3, 5))); // Should change
    });
  });
}
