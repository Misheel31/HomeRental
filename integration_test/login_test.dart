import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/home/presentation/widget/location_search.dart';
import 'package:home_rental/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login Test with Mock Data', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back!'), findsOneWidget);

    await tester.enterText(
        find.byType(TextFormField).at(0), 'misheel123@gmail.com');
    await tester.enterText(find.byType(TextFormField).at(1), '123456789');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    print('API response received');

    await tester.pumpAndSettle(const Duration(seconds: 5));

    for (var widget in tester.allWidgets) {
      if (widget is Text) print('Found Text Widget: ${widget.data}');
    }

    expect(find.text('Rentify'), findsOneWidget);
    expect(find.byType(LocationSearch), findsOneWidget);
  });
}
