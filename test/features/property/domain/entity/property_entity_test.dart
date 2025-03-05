import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';

void main() {
  group('PropertyEntity', () {
    test('should create a PropertyEntity with the given values', () {
      const property1 = PropertyEntity(
        id: '1',
        title: 'House',
        description: 'abc',
        location: '123 house',
        image: 'house.png',
        pricePerNight: 200,
        available: true,
        bedCount: 2,
        bedroomCount: 2,
        city: 'Miami',
        state: 'FL',
        country: 'USA',
        amenities: ['wifi', 'Pool'],
        bathroomCount: 1,
        guestCount: 2,
      );

      expect(property1.id, '1');
      expect(property1.title, 'House');
      expect(property1.description, 'abc');
      expect(property1.location, '123 house');
      expect(property1.image, 'house.png');
      expect(property1.pricePerNight, 200);
      expect(property1.available, true);
      expect(property1.bedCount, 2);
      expect(property1.bedroomCount, 2);
      expect(property1.city, 'Miami');
      expect(property1.state, 'FL');
      expect(property1.country, 'USA');
      expect(property1.amenities, ['wifi', 'Pool']);
      expect(property1.bathroomCount, 1);
      expect(property1.guestCount, 2);
    });

    test('should compare two PropertyEntity objects for equality', () {
      const property1 = PropertyEntity(
        id: '1',
        title: 'House',
        description: 'abc',
        location: '123 house',
        image: 'house.png',
        pricePerNight: 200,
        available: true,
        bedCount: 2,
        bedroomCount: 2,
        city: 'Miami',
        state: 'FL',
        country: 'USA',
        amenities: ['wifi', 'Pool'],
        bathroomCount: 1,
        guestCount: 2,
      );

      const property3 = PropertyEntity(
        id: '2',
        title: 'Mountain Cabin',
        description: 'A cozy cabin in the mountains.',
        location: '456 Mountain Rd',
        image: 'mountain_cabin.png',
        pricePerNight: 250.0,
        available: false,
        bedCount: 2,
        bedroomCount: 1,
        city: 'Denver',
        state: 'CO',
        country: 'USA',
        guestCount: 4,
        bathroomCount: 1,
        amenities: ['Wi-Fi', 'Fireplace'],
      );

      expect(property1, isNot(equals(property3)));
      expect(property3, isNot(equals(property1)));
    });

    test(
        'should correctly handle the equality of a PropertyEntity with null id',
        () {
      const property1 = PropertyEntity(
        id: null,
        title: 'Beach House',
        description: 'A beautiful beach house near the coast.',
        location: '123 Beach Ave',
        image: 'beach_house.png',
        pricePerNight: 200.0,
        available: true,
        bedCount: 3,
        bedroomCount: 2,
        city: 'Miami',
        state: 'FL',
        country: 'USA',
        guestCount: 6,
        bathroomCount: 2,
        amenities: ['Wi-Fi', 'Pool'],
      );

      const property2 = PropertyEntity(
        id: null,
        title: 'Beach House',
        description: 'A beautiful beach house near the coast.',
        location: '123 Beach Ave',
        image: 'beach_house.png',
        pricePerNight: 200.0,
        available: true,
        bedCount: 3,
        bedroomCount: 2,
        city: 'Miami',
        state: 'FL',
        country: 'USA',
        guestCount: 6,
        bathroomCount: 2,
        amenities: ['Wi-Fi', 'Pool'],
      );
      expect(property1, equals(property2));
    });
  });
}
