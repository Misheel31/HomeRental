import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/features/wishlist/presentation/widget/wishlist_item.dart';
import 'package:http/http.dart' as http;

class WishlistList extends StatefulWidget {
  const WishlistList({super.key});

  @override
  _WishlistListState createState() => _WishlistListState();
}

class _WishlistListState extends State<WishlistList> {
  List wishlist = [];
  String error = '';
  final String username = 'misheel';

  @override
  void initState() {
    super.initState();
    fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    final url = '${ApiEndpoints.baseUrl}wishlist/$username';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          wishlist = List.from(data);
        });
      } else {
        setState(() {
          error = 'No wishlist items found';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error fetching wishlist : $e';
      });
    }
  }

  Future<void> removeWishlistItem(String itemId) async {
    final url = '${ApiEndpoints.baseUrl}wishlist/$itemId';
    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          wishlist = wishlist.where((item) => item['_id'] != itemId).toList();
        });
      } else {
        setState(() {
          error = 'Failed to remove item from wishlsit';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error removing item from wishlist :$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (error.isNotEmpty)
            Text(
              error,
              style: const TextStyle(color: Colors.red),
            ),
          if (wishlist.isEmpty && error.isEmpty)
            const Center(child: Text('No wishlist items found.')),
          if (wishlist.isNotEmpty)
            Expanded(
                child: ListView.builder(
                    itemCount: wishlist.length,
                    itemBuilder: (context, index) {
                      return WishlistItem(
                        item: wishlist[index],
                        onRemove: removeWishlistItem,
                      );
                    }))
        ],
      ),
    );
  }
}
