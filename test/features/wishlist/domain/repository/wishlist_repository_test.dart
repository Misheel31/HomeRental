import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:home_rental/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockWishlistRepository extends Mock implements IWishlistRepository {}

void main() {
  late MockWishlistRepository mockWishlistRepository;

  setUp(() {
    mockWishlistRepository = MockWishlistRepository();
  });

  group('IWishlistRepository', () {
    const testUsername = 'test_user';
    const testWishlist = WishlistEntity(
      id: '1',
      title: 'Test',
      description: 'description',
      image: 'image.png',
      pricePerNight: '200',
      location: 'USA',
      username: 'username',
      propertyId: '1',
    );

    test('should return a list of wishlist items when getWishlist is called',
        () async {
      // Correct way to mock a method
      when(() => mockWishlistRepository.getWishlist(testUsername))
          .thenAnswer((_) async => [testWishlist]);

      final result = await mockWishlistRepository.getWishlist(testUsername);

      expect(result, isA<List<WishlistEntity>>());
      expect(result.length, 1);
      expect(result.first, testWishlist);

      verify(() => mockWishlistRepository.getWishlist(testUsername)).called(1);
      verifyNoMoreInteractions(mockWishlistRepository);
    });

    test('should add item to wishlist when addToWishlist is called', () async {
      when(() => mockWishlistRepository.addToWishlist(testWishlist))
          .thenAnswer((_) async {
        return;
      });

      await mockWishlistRepository.addToWishlist(testWishlist);

      verify(() => mockWishlistRepository.addToWishlist(testWishlist))
          .called(1);
      verifyNoMoreInteractions(mockWishlistRepository);
    });

    test('should remove item from wishlist when removeFromWishlist is called',
        () async {
      const wishlistId = '1';
      when(() => mockWishlistRepository.removeFromWishlist(wishlistId))
          .thenAnswer((_) async {
        return;
      });

      await mockWishlistRepository.removeFromWishlist(wishlistId);

      verify(() => mockWishlistRepository.removeFromWishlist(wishlistId))
          .called(1);
      verifyNoMoreInteractions(mockWishlistRepository);
    });
  });
}
