import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/home/presentation/widget/location_search.dart';
import 'package:home_rental/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('LoginViewTest', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back!'), findsOneWidget);

    final emailField = find.byType(TextFormField).at(0);
    final passwordField = find.byType(TextFormField).at(1);
    final loginButton = find.byType(ElevatedButton);

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);

    await tester.enterText(emailField, 'abc@gmail.com');
    await tester.enterText(passwordField, '123456789');

    await tester.tap(loginButton);
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);

    expect(find.text('Rentify'), findsOneWidget);
    expect(find.byType(LocationSearch), findsOneWidget);
  });
}
