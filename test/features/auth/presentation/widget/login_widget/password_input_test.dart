import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/presentation/widget/login_widget/password_input.dart';

void main() {
  testWidgets('PasswordInputWidget test', (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();
    bool isPasswordVisible = false;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void toggleVisibility() {
      isPasswordVisible = !isPasswordVisible;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: StatefulBuilder(
              builder: (context, setState) {
                return PasswordInputWidget(
                  controller: controller,
                  isPasswordVisible: isPasswordVisible,
                  togglePasswordVisibility: () {
                    setState(() {
                      toggleVisibility();
                    });
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    final Finder visibilityOffIcon = find.byIcon(Icons.visibility_off);
    final Finder visibilityOnIcon = find.byIcon(Icons.visibility);

    expect(visibilityOffIcon, findsOneWidget);

    await tester.tap(visibilityOffIcon);
    await tester.pumpAndSettle();

    expect(visibilityOnIcon, findsOneWidget);

    await tester.tap(visibilityOnIcon);
    await tester.pumpAndSettle();

    expect(visibilityOffIcon, findsOneWidget);

    formKey.currentState!.validate();
    await tester.pump();

    expect(find.text('Please enter your password'), findsOneWidget);
  });
}
