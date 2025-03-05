import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/wishlist/domain/entity/wishlist_entity.dart';

void main() {
  group('WishlistEntity', () {
    test('should be a valid WishlistEntity object', () {
      const wishlistEntity = WishlistEntity(
        id: '1',
        title: 'Property Title',
        description: 'Property Description',
        image: 'property_image_url',
        pricePerNight: '100',
        location: 'City, Country',
        username: 'user123',
        propertyId: '12345',
      );

      expect(wishlistEntity.id, '1');
      expect(wishlistEntity.title, 'Property Title');
      expect(wishlistEntity.description, 'Property Description');
      expect(wishlistEntity.pricePerNight, '100');
      expect(wishlistEntity.location, 'City, Country');
      expect(wishlistEntity.username, 'user123');
      expect(wishlistEntity.propertyId, '12345');
    });
  });
}
