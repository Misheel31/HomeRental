import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/booking/presentation/widget/total_price_display.dart';

void main() {
  testWidgets(
      'TotalPriceDisplay shows the correct price when totalPrice is greater than 0',
      (WidgetTester tester) async {
    double totalPrice = 150.75;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TotalPriceDisplay(totalPrice: totalPrice),
        ),
      ),
    );

    expect(find.text('Total Price: \$150.75'), findsOneWidget);
  });

  testWidgets('TotalPriceDisplay shows nothing when totalPrice is 0 or less',
      (WidgetTester tester) async {
    double totalPrice = 0.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TotalPriceDisplay(totalPrice: totalPrice),
        ),
      ),
    );

    expect(find.byType(Text), findsNothing);
  });
}
