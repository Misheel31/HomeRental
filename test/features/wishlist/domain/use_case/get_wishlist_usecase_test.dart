import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:home_rental/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:home_rental/features/wishlist/domain/use_case/get_wishlist_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockWishlistRepository extends Mock implements IWishlistRepository {}

void main() {
  late MockWishlistRepository repository;
  late GetWishlistUseCase usecase;

  setUp(() {
    repository = MockWishlistRepository();
    usecase = GetWishlistUseCase(repository);
  });

  const tWishlist = WishlistEntity(
    id: '1',
    title: 'Property 1',
    description: 'A beautiful place to stay.',
    location: 'London',
    image: 'image_url',
    pricePerNight: '100',
    username: 'username',
    propertyId: '1',
  );

  const tWishlist2 = WishlistEntity(
    id: '2',
    title: 'Property 2',
    description: 'Another great place.',
    location: 'New York',
    image: 'image_url_2',
    pricePerNight: '150',
    username: 'user',
    propertyId: '2',
  );

  final tWishlistList = [tWishlist, tWishlist2];
  const tUserId = 'user_123';

  test('Get wishlist returns correct data from repository', () async {
    // Arrange
    when(() => repository.getWishlist(tUserId))
        .thenAnswer((_) async => tWishlistList);

    // Act
    final result = await usecase(tUserId);

    // Assert
    expect(result, tWishlistList);
    verify(() => repository.getWishlist(tUserId)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('Get wishlist returns empty list if no items in the wishlist', () async {
    // Arrange
    when(() => repository.getWishlist(tUserId)).thenAnswer((_) async => []);

    // Act
    final result = await usecase(tUserId);

    // Assert
    expect(result, []);
    verify(() => repository.getWishlist(tUserId)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('Get wishlist throws an error if repository fails', () async {
    // Arrange
    when(() => repository.getWishlist(tUserId))
        .thenThrow(Exception('Failed to fetch wishlist'));

    // Act
    final call = usecase(tUserId);

    // Assert
    expect(() => call, throwsA(isA<Exception>()));
    verify(() => repository.getWishlist(tUserId)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
