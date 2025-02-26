part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadWishlist extends WishlistEvent {
  final String username;

  const LoadWishlist(this.username);

  @override
  List<Object?> get props => [username];
}

class RemoveFromWishlist extends WishlistEvent {
  final String id;

  const RemoveFromWishlist(this.id);

  @override
  List<Object?> get props => [id];
}

class AddToWishlist extends WishlistEvent {
  final String propertyId;
  final String title;
  final String location;
  final String image;
  final double pricePerNight;

  const AddToWishlist({
    required this.propertyId,
    required this.title,
    required this.location,
    required this.image,
    required this.pricePerNight,
  });

  @override
  List<Object?> get props =>
      [propertyId, title, location, image, pricePerNight];
}
