import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/wishlist/domain/use_case/remove_wishlist_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'add_wishlist_usecase_test.dart';

void main() {
  late MockWishlistRepository mockWishlistRepository;
  late RemoveFromWishlistUseCase removeFromWishlistUseCase;

  setUp(() {
    mockWishlistRepository = MockWishlistRepository();
    removeFromWishlistUseCase =
        RemoveFromWishlistUseCase(mockWishlistRepository);

    when(() => mockWishlistRepository.removeFromWishlist(any()))
        .thenAnswer((_) async => Future.value());
  });

  group('RemoveFromWishlistUseCase', () {
    test('should call removeFromWishlist method of repository', () async {
      const wishlistId = "1";

      await removeFromWishlistUseCase.call(wishlistId);
      verify(() => mockWishlistRepository.removeFromWishlist(wishlistId))
          .called(1);
    });

    test('should throw an exception when the repository call fails', () async {
      when(() => mockWishlistRepository.removeFromWishlist(any()))
          .thenThrow(Exception('Failed to remove from wishlist'));

      expect(() => removeFromWishlistUseCase.call("1"), throwsException);

      verify(() => mockWishlistRepository.removeFromWishlist('1')).called(1);
    });
  });
}
