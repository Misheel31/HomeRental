import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/presentation/widget/register_widget/input_field_widget.dart';

void main() {
  testWidgets('InputFieldWidget test', (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();
    const String testLabel = 'Email';
    const String testInput = 'test@example.com';

    String? mockValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'Field cannot be empty';
      }
      return null;
    }

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: InputFieldWidget(
              controller: controller,
              labelText: testLabel,
              prefixIcon: const Icon(Icons.email),
              validator: mockValidator,
            ),
          ),
        ),
      ),
    );

    expect(find.text(testLabel), findsOneWidget);

    final textFieldFinder = find.byType(TextFormField);
    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, testInput);
    await tester.pump();

    expect(controller.text, testInput);

    await tester.enterText(textFieldFinder, '');
    await tester.pump();

    formKey.currentState!.validate();
    await tester.pump();

    expect(find.text('Field cannot be empty'), findsOneWidget);
  });
}
