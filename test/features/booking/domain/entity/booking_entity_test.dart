import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';

void main() {
  group('BookingEntity test', () {
    test('should create an instance with given properties', () {
      const username = 'test_user';
      const startDate = '2025-02-22';
      const endDate = '2025-02-23';
      const totalPrice = '100.0';
      const propertyId = 'property_123';

      const booking = BookingEntity(
        username: username,
        startDate: startDate,
        endDate: endDate,
        totalPrice: totalPrice,
        propertyId: propertyId,
      );

      // Assert
      expect(booking.username, username);
      expect(booking.startDate, startDate);
      expect(booking.endDate, endDate);
      expect(booking.totalPrice, totalPrice);
      expect(booking.propertyId, propertyId);
    });

    test('should compare objects based on properties', () {
      // Arrange
      const booking1 = BookingEntity(
        username: 'user1',
        startDate: '2025-02-22',
        endDate: '2025-02-23',
        totalPrice: '200.0',
        propertyId: 'property_1',
      );

      const booking2 = BookingEntity(
        username: 'user1',
        startDate: '2025-02-22',
        endDate: '2025-02-23',
        totalPrice: '200.0',
        propertyId: 'property_1',
      );

      const booking3 = BookingEntity(
        username: 'user2',
        startDate: '2025-02-22',
        endDate: '2025-02-23',
        totalPrice: '200.0',
        propertyId: 'property_2',
      );

      // Assert
      expect(booking1, equals(booking2));
      expect(booking1, isNot(equals(booking3)));
    });
  });
}
