import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/presentation/widget/register_widget/sign_in_redirect_widget.dart';

void main() {
  testWidgets('SignInRedirectWidget test', (WidgetTester tester) async {
    bool isTapped = false;
    void mockOnTap() {
      isTapped = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SignInRedirectWidget(onTap: mockOnTap),
        ),
      ),
    );

    expect(find.text('Already have an account?'), findsOneWidget);

    expect(find.text('Sign In'), findsOneWidget);

    await tester.tap(find.text('Sign In'));
    await tester.pump();
    expect(isTapped, true);
  });
}
