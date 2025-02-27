import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/app/widget/custom_elevated_button.dart';

void main() {
  testWidgets('custom elevated button triggers onPressed when tapped',
      (WidgetTester tester) async {
    bool wasPressed = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomElevatedButton(
          onPressed: () {
            wasPressed = true;
          },
          text: 'Login',
        ),
      ),
    ));
    expect(find.text('Login'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(wasPressed, isTrue);
  });
}
