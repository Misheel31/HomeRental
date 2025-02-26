import 'package:home_rental/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:home_rental/features/wishlist/domain/repository/wishlist_repository.dart';

class AddToWishlistUseCase {
  final IWishlistRepository repository;

  AddToWishlistUseCase(this.repository);

  Future<void> call(WishlistEntity wishlist) async {
    await repository.addToWishlist(wishlist);
  }
}