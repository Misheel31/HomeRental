import 'package:home_rental/features/wishlist/domain/entity/wishlist_entity.dart';

abstract interface class IWishlistDataSource {
  Future<List<WishlistEntity>> getWishlist(String userId);
  Future<void> removeFromWishlist(String id, String? token);
  Future<void> addToWishlist(WishlistEntity wishlist);
}
