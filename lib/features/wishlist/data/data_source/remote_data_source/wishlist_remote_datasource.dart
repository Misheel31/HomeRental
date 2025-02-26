import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/features/wishlist/data/data_source/wishlist_data_source.dart';
import 'package:home_rental/features/wishlist/data/model/wishlist_api_model.dart';
import 'package:home_rental/features/wishlist/domain/entity/wishlist_entity.dart';

class WishlistRemoteDatasource implements IWishlistDataSource {
  final Dio _dio;

  WishlistRemoteDatasource({required Dio dio}) : _dio = dio;

  @override
  Future<void> addToWishlist(WishlistEntity wishlist) async {
    const url = 'http://192.168.1.70:3000/api/wishlist';
    try {
      final response = await _dio.post(url,
          data: json.encode({
            'propertyId': wishlist.propertyId,
            'title': wishlist.title,
            'location': wishlist.location,
            'image': wishlist.image,
            'pricePerNight': wishlist.pricePerNight,
          }));
      if (response.statusCode == 200) {
        print('Item added to wishlist');
      } else {
        throw Exception('Failed to add item to wishlist');
      }
    } catch (e) {
      throw Exception('Error adding to wishlist: $e');
    }
  }

  @override
  Future<void> removeFromWishlist(String id, String? token) async {
    try {
      var response = await _dio.delete(
        '${ApiEndpoints.removeWishlist}$id',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<WishlistEntity>> getWishlist(String username) async {
    try {
      var url = 'http://192.168.1.70:3000/api/wishlist/$username';
      var response = await _dio.get(url);

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        List<dynamic> wishlistData = response.data;
        return wishlistData
            .map((item) => WishlistApiModel.fromJson(item).toEntity())
            .toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception();
    }
  }
}
