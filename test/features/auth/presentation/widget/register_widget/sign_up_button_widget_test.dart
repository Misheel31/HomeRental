import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/presentation/widget/register_widget/sign_up_button_widget.dart';

void main() {
  testWidgets('SignUpButtonWidget test', (WidgetTester tester) async {
    bool isPressed = false;
    void mockOnPressed() {
      isPressed = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SignUpButtonWidget(onPressed: mockOnPressed),
        ),
      ),
    );

    expect(find.text('Sign Up'), findsOneWidget);

    expect(find.byType(SizedBox), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.tap(find.text('Sign Up'));
    await tester.pump();

    expect(isPressed, true);
  });
}
