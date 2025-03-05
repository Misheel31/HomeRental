import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/presentation/widget/register_widget/password_field_widegt.dart';

void main() {
  group('PasswordFieldWidget Test', () {
    late TextEditingController controller;
    bool isPasswordVisible = false;

    setUp(() {
      controller = TextEditingController();
    });

    testWidgets('should render with label and icons',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PasswordFieldWidegt(
              controller: controller,
              labelText: 'Password',
              isPasswordVisible: isPasswordVisible,
              onToggleVisibility: () {}),
        ),
      ));

      expect(find.text('Password'), findsOneWidget);

      expect(find.byIcon(Icons.lock), findsOneWidget);

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('should toggle password visibilty when icon is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return PasswordFieldWidegt(
                controller: controller,
                labelText: 'Password',
                isPasswordVisible: isPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              );
            },
          ),
        ),
      ));
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('should update text field value', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PasswordFieldWidegt(
              controller: controller,
              labelText: 'Password',
              isPasswordVisible: isPasswordVisible,
              onToggleVisibility: () {}),
        ),
      ));
      await tester.enterText(find.byType(TextFormField), 'Testpassword');
      await tester.pump();
      expect(controller.text, 'Testpassword');
    });

    testWidgets('should validate the password input',
        (WidgetTester tester) async {
      String? validator(String? value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty';
        }
        return null;
      }

      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: PasswordFieldWidegt(
              controller: controller,
              labelText: 'Password',
              isPasswordVisible: isPasswordVisible,
              onToggleVisibility: () {},
              validator: validator,
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(TextFormField));
      await tester.pump();

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Password cannot be empty'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'Testpassword');
      await tester.pump();

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Password cannot be empty'), findsNothing);
    });
  });
}
