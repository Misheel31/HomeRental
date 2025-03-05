import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/app/app.dart';
import 'package:home_rental/app/di/di.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('HomePage Test', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({
        'username': 'testuser',
        'someKey': ['item1', 'item2'],
      });

      final mockSharedPreferences = MockSharedPreferences();

      when(() => mockSharedPreferences.getString('username'))
          .thenReturn('testuser');
      when(() => mockSharedPreferences.getStringList('someKey'))
          .thenReturn(['item1', 'item2']);

      getIt.registerSingleton<SharedPreferences>(mockSharedPreferences);

      await initDependencies();
    });

    testWidgets('should display properties, filter by price, and navigate',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.pumpAndSettle();

      debugDumpApp();

      expect(find.textContaining('No properties found'), findsNothing);

      final Finder minPricedField = find.byKey(const Key('minPriceField'));
      final Finder maxPricedField = find.byKey(const Key('maxPriceField'));

      if (minPricedField.evaluate().isNotEmpty &&
          maxPricedField.evaluate().isNotEmpty) {
        await tester.enterText(minPricedField, '500');
        await tester.enterText(maxPricedField, '3000');
      }

      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);

      final Finder wishlistButton = find.byIcon(Icons.favorite);
      await tester.tap(wishlistButton);
      await tester.pumpAndSettle();

      expect(find.text('Favorites'), findsOneWidget);

      final Finder homeButton = find.byIcon(Icons.home);
      await tester.tap(homeButton);
      await tester.pumpAndSettle();

      final Finder bookingButton = find.byIcon(Icons.calendar_today);
      await tester.tap(bookingButton);
      await tester.pumpAndSettle();

      expect(find.text('Booking'), findsOneWidget);

      await tester.tap(homeButton);
      await tester.pumpAndSettle();

      final Finder profileButton = find.byIcon(Icons.person);
      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      expect(find.text('Profile'), findsOneWidget);
    });
  });
}
