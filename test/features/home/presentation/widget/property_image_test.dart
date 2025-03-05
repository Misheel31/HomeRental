import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/home/presentation/widget/property_image.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';

void main() {
  testWidgets('PropertyImage widget test', (WidgetTester tester) async {
    const property = PropertyApiModel(
      id: '1',
      title: 'Test Property',
      description: 'A nice property',
      pricePerNight: 1000,
      image: 'images.jpg',
      location: 'abc',
      bedCount: 2,
      bedroomCount: 2,
      city: 'abc',
      state: 'abc',
      country: 'abc',
      guestCount: 2,
      bathroomCount: 1,
      amenities: ['wifi', 'hee'],
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PropertyImage(property: property),
        ),
      ),
    );

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);

    final ClipRRect clipRRect = tester.widget(find.byType(ClipRRect));
    expect(
        clipRRect.borderRadius,
        const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ));
  });
}
