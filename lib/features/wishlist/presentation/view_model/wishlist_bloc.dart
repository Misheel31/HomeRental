import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:home_rental/features/wishlist/domain/repository/wishlist_repository.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final IWishlistRepository wishlistRepository;

  WishlistBloc(this.wishlistRepository) : super(WishlistInitial()) {
    on<LoadWishlist>((event, emit) async {
      emit(WishlistLoading());
      try {
        final wishlist = await wishlistRepository.getWishlist(event.username);
        print("Fetched Wishlist: $wishlist");
        emit(WishlistLoaded(wishlist));
      } catch (e) {
        emit(WishlistError('Failed to load wishlist: $e'));
      }
    });

    on<RemoveFromWishlist>((event, emit) async {
      try {
        emit(WishlistLoading());
        await wishlistRepository.removeFromWishlist(event.id);
        final updatedWishlist = await wishlistRepository.getWishlist(event.id);
        emit(WishlistLoaded(updatedWishlist));
      } catch (e) {
        emit(WishlistError('Failed to remove item from wishlist: $e'));
      }
    });

    on<AddToWishlist>((event, emit) async {
      try {
        emit(WishlistLoading());
        await wishlistRepository.addToWishlist(
          WishlistEntity(
            username: event.propertyId,
            propertyId: event.propertyId,
            title: event.title,
            location: event.location,
            image: event.image,
            pricePerNight: event.pricePerNight.toString(),
            id: '',
            description: '',
          ),
        );

        final updatedWishlist =
            await wishlistRepository.getWishlist(event.propertyId);
        emit(WishlistLoaded(updatedWishlist));
      } catch (e) {
        emit(WishlistError('Failed to add item to wishlist: $e'));
      }
    });
  }
}
