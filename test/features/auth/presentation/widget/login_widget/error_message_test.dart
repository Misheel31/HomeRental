import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/presentation/widget/login_widget/error_message.dart';

void main() {
  group('ErrorMessage Widget Tests', () {
    testWidgets('Displays error message when provided',
        (WidgetTester tester) async {
      // Arrange
      const errorMessage = 'This is an error message';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ErrorMessage(message: errorMessage),
          ),
        ),
      );

      // Assert
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('Does not display when message is null',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ErrorMessage(message: null),
          ),
        ),
      );

      // Assert
      expect(find.byType(Text), findsNothing);
    });
  });
}
