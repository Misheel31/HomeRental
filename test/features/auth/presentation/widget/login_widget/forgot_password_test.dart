import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/presentation/widget/login_widget/forgot_password.dart';

void main() {
  testWidgets('ForgotPassword widget test', (WidgetTester tester) async {
    bool wasTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ForgotPassword(
            onTap: () {
              wasTapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text("Forgot password?"), findsOneWidget);

    await tester.tap(find.text("Forgot password?"));
    await tester.pump();
    expect(wasTapped, isTrue);
  });
}
