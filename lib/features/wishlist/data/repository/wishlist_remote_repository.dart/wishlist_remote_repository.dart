import 'dart:convert';

import 'package:home_rental/features/wishlist/data/data_source/remote_data_source/wishlist_remote_datasource.dart';
import 'package:home_rental/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:home_rental/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:http/http.dart' as http;

class WishlistRemoteRepository implements IWishlistRepository {
  final WishlistRemoteDatasource _remoteDatasource;

  WishlistRemoteRepository({required WishlistRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<void> addToWishlist(WishlistEntity wishlist) async {
    const url = 'http://192.168.1.70:3000/api/wishlist/create';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': wishlist.username,
          'propertyId': wishlist.propertyId,
          'title': wishlist.title,
          'location': wishlist.location,
          'image': wishlist.image,
          'pricePerNight': double.tryParse(wishlist.pricePerNight.toString()),
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to add to wishlist');
      }
    } catch (error) {
      print('Error adding to wishlist: $error');
      rethrow;
    }
  }

  @override
  Future<void> removeFromWishlist(String id) async {
    return await _remoteDatasource.removeFromWishlist(id, null);
  }

  @override
  Future<List<WishlistEntity>> getWishlist(String userId) async {
    return await _remoteDatasource.getWishlist(userId);
  }
}
