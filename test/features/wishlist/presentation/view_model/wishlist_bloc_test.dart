import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:home_rental/features/wishlist/presentation/view_model/wishlist_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/use_case/add_wishlist_usecase_test.dart';

void main() {
  late MockWishlistRepository mockWishlistRepository;
  late WishlistBloc wishlistBloc;

  setUpAll(() {
    registerFallbackValue(const WishlistEntity(
      id: '1',
      title: 'Dummy Title',
      image: 'dummy_image.avif',
      pricePerNight: '50',
      location: 'Dummy Location',
      username: 'dummy_user',
      propertyId: 'dummy_property_id',
      description: 'dummy description',
    ));
  });

  setUp(() {
    mockWishlistRepository = MockWishlistRepository();
    wishlistBloc = WishlistBloc(mockWishlistRepository);
  });

  group('WishlistBloc', () {
    test('initial state is WishlistInitial', () {
      expect(wishlistBloc.state, WishlistInitial());
    });

    blocTest<WishlistBloc, WishlistState>(
      'emits WishlistLoading and WishlistLoaded when LoadWishlist is added',
      build: () {
        when(() => mockWishlistRepository.getWishlist(any()))
            .thenAnswer((_) async => [
                  const WishlistEntity(
                    id: '1',
                    title: 'Adriatic Jewel',
                    image: 'image1.avif',
                    pricePerNight: '50',
                    location: 'Italy',
                    username: 'abc',
                    propertyId: '67a75db463ea800f374f3101',
                    description: '',
                  )
                ]);
        return wishlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWishlist('abc')),
      expect: () => [
        WishlistLoading(),
        const WishlistLoaded([
          WishlistEntity(
            id: '1',
            title: 'Adriatic Jewel',
            image: 'image1.avif',
            pricePerNight: '50',
            location: 'Italy',
            username: 'abc',
            propertyId: '67a75db463ea800f374f3101',
            description: '',
          )
        ]),
      ],
    );

    blocTest<WishlistBloc, WishlistState>(
      'emits WishlistLoading and WishlistError when LoadWishlist fails',
      build: () {
        when(() => mockWishlistRepository.getWishlist(any()))
            .thenThrow(Exception('Failed to load wishlist'));
        return wishlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWishlist('abc')),
      expect: () => [
        WishlistLoading(),
        const WishlistError(
            'Failed to load wishlist: Exception: Failed to load wishlist'),
      ],
    );

    blocTest<WishlistBloc, WishlistState>(
      'emits WishlistLoading and WishlistLoaded when RemoveFromWishlist is added',
      build: () {
        when(() => mockWishlistRepository.removeFromWishlist(any()))
            .thenAnswer((_) async {});
        when(() => mockWishlistRepository.getWishlist(any()))
            .thenAnswer((_) async => []);
        return wishlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWishlist('1')),
      expect: () => [
        WishlistLoading(),
        const WishlistLoaded([]),
      ],
    );

    blocTest<WishlistBloc, WishlistState>(
      'emits WishlistLoading and WishlistError when RemoveFromWishlist fails',
      build: () {
        when(() => mockWishlistRepository.removeFromWishlist(any()))
            .thenThrow(Exception('Failed to remove item'));
        return wishlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWishlist('1')),
      expect: () => [
        WishlistLoading(),
        const WishlistError(
            'Failed to remove item from wishlist: Exception: Failed to remove item'),
      ],
    );

    blocTest<WishlistBloc, WishlistState>(
      'emits WishlistLoading and WishlistLoaded when AddToWishlist is added',
      build: () {
        when(() => mockWishlistRepository.addToWishlist(any()))
            .thenAnswer((_) async {});
        when(() => mockWishlistRepository.getWishlist(any()))
            .thenAnswer((_) async => [
                  const WishlistEntity(
                    id: '1',
                    title: 'Adriatic Jewel',
                    image: 'image1.avif',
                    pricePerNight: '50',
                    location: 'Italy',
                    username: 'abc',
                    propertyId: '67a75db463ea800f374f3101',
                    description: '',
                  )
                ]);
        return wishlistBloc;
      },
      act: (bloc) => bloc.add(const AddToWishlist(
        propertyId: '67a75db463ea800f374f3101',
        title: 'Adriatic Jewel',
        location: 'Italy',
        image: 'image1.avif',
        pricePerNight: 50.0,
      )),
      expect: () => [
        WishlistLoading(),
        const WishlistLoaded([
          WishlistEntity(
            id: '1',
            title: 'Adriatic Jewel',
            image: 'image1.avif',
            pricePerNight: '50',
            location: 'Italy',
            username: 'abc',
            propertyId: '67a75db463ea800f374f3101',
            description: '',
          )
        ]),
      ],
    );

    blocTest<WishlistBloc, WishlistState>(
      'emits WishlistLoading and WishlistError when AddToWishlist fails',
      build: () {
        when(() => mockWishlistRepository.addToWishlist(any()))
            .thenThrow(Exception('Failed to add item'));
        return wishlistBloc;
      },
      act: (bloc) => bloc.add(const AddToWishlist(
        propertyId: '67a75db463ea800f374f3101',
        title: 'Adriatic Jewel',
        location: 'Italy',
        image: 'image1.avif',
        pricePerNight: 50.0,
      )),
      expect: () => [
        WishlistLoading(),
        const WishlistError(
            'Failed to add item to wishlist: Exception: Failed to add item'),
      ],
    );
  });
}
