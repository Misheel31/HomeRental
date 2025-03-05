import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:home_rental/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:home_rental/features/wishlist/domain/use_case/add_wishlist_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockWishlistRepository extends Mock implements IWishlistRepository {}

void main() {
  late MockWishlistRepository mockWishlistRepository;
  late AddToWishlistUseCase addToWishlistUseCase;

  setUpAll(() {
    registerFallbackValue(const WishlistEntity(
      id: "1",
      title: 'Test wishlist',
      description: 'Test wishlist',
      image: 'image',
      pricePerNight: '200',
      location: 'location',
      username: 'username',
      propertyId: 'propertyId',
    ));
  });

  setUp(() {
    mockWishlistRepository = MockWishlistRepository();
    addToWishlistUseCase = AddToWishlistUseCase(mockWishlistRepository);

    when(() => mockWishlistRepository.addToWishlist(any()))
        .thenAnswer((_) async => Future.value(null));
  });

  group('Add To wishlistUsecase', () {
    test('should call addToWishlist method of repository', () async {
      const wishlistEntity = WishlistEntity(
        id: "1",
        title: 'Test wishlist',
        description: 'Test wishlist',
        image: 'image',
        pricePerNight: '200',
        location: 'location',
        username: 'username',
        propertyId: 'propertyId',
      );

      await addToWishlistUseCase.call(wishlistEntity);

      verify(() => mockWishlistRepository.addToWishlist(wishlistEntity))
          .called(1);
    });
  });
}
