import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';
import 'package:home_rental/features/property/presentation/widget/property_image_carousel.dart';

void main() {
  group('PropertyImageCarousel Tests', () {
    testWidgets('Renders PropertyImageCarousel with images',
        (WidgetTester tester) async {
      // Arrange
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

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PropertyImageCarousel(property: property),
          ),
        ),
      );

      // Assert
      expect(find.byType(Image), findsNWidgets(property.image.length));
    });

    testWidgets('Uses default image URL if image does not start with "http"',
        (WidgetTester tester) async {
      // Arrange
      const property = PropertyApiModel(
        id: '2',
        title: 'Offline Property',
        description: 'An offline image property',
        pricePerNight: 1200,
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

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PropertyImageCarousel(property: property),
          ),
        ),
      );

      // Assert
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Image && widget.image is NetworkImage,
        ),
        findsOneWidget,
      );
    });

    testWidgets('Renders a single image if image is not a list',
        (WidgetTester tester) async {
      // Arrange
      const property = PropertyApiModel(
        id: '3',
        title: 'Single Image Property',
        description: 'Has only one image',
        pricePerNight: 900,
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

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PropertyImageCarousel(property: property),
          ),
        ),
      );

      // Assert
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
