import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/presentation/widget/login_widget/email_input.dart';

void main() {
  group('EmailInput Widget Tests', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    testWidgets('Renders EmailInput widget correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailInput(controller: controller),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);

      expect(find.text('Email'), findsOneWidget);

      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('Displays validation error when email is empty',
        (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: EmailInput(controller: controller),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Please enter your email'), findsOneWidget);
    });

    testWidgets('Updates text field when user enters email',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailInput(controller: controller),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'test@example.com');

      expect(controller.text, 'test@example.com');
    });
  });
}
