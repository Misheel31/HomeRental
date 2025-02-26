import 'package:home_rental/features/wishlist/domain/entity/wishlist_entity.dart';

abstract interface class IWishlistRepository {
  Future<List<WishlistEntity>> getWishlist(String username);
  Future<void> addToWishlist(WishlistEntity wishlist);
  Future<void> removeFromWishlist(String wishlistId);
}
