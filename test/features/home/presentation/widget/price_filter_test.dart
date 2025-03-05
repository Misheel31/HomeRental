import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/home/presentation/widget/price_filter.dart';

void main() {
  testWidgets('PriceFilter widget test', (WidgetTester tester) async {
    String minPrice = '';
    String maxPrice = '';

    void onMinPriceChanged(String value) {
      minPrice = value;
    }

    void onMaxPriceChanged(String value) {
      maxPrice = value;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PriceFilter(
            minPriceController: TextEditingController(),
            maxPriceController: TextEditingController(),
            onMinPriceChanged: onMinPriceChanged,
            onMaxPriceChanged: onMaxPriceChanged,
          ),
        ),
      ),
    );

    final minPriceField = find.byType(TextField).first;
    final maxPriceField = find.byType(TextField).at(1);

    await tester.enterText(minPriceField, '50000');
    await tester.enterText(maxPriceField, '150000');

    await tester.pump();

    expect(minPrice, '50000');
    expect(maxPrice, '150000');
  });
}
