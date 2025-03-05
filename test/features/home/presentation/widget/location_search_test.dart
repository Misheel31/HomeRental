import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/home/presentation/widget/location_search.dart';

void main() {
  testWidgets('location search should call onLocationChnaged text is entered',
      (WidgetTester tester) async {
    final locationController = TextEditingController();
    String changesText = '';
    void onLocationChanged(String text) {
      changesText = text;
    }

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LocationSearch(
            locationController: locationController,
            onLocationChanged: onLocationChanged),
      ),
    ));

    expect(find.byType(TextField), findsOneWidget);
    expect(locationController.text, '');

    await tester.enterText(find.byType(TextField), 'Location Search');
    await tester.pump();

    expect(changesText, 'Location Search');
    expect(locationController.text, 'Location Search');
  });
}
