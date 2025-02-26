import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:home_rental/features/booking/presentation/view/get_booking.dart';
import 'package:home_rental/features/home/presentation/view/home_view.dart';
import 'package:home_rental/features/home/presentation/widget/bottom_navigation_bar.dart';
import 'package:home_rental/features/profile/data/data_source/remote_datasource/profile_remote_datasource.dart';
import 'package:home_rental/features/profile/data/repository/profile_remote_repository/profile_remote_repository.dart';
import 'package:home_rental/features/profile/domain/use_case/fetch_user_usecase.dart';
import 'package:home_rental/features/profile/presentation/view/profile_view.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';
import 'package:home_rental/features/wishlist/data/repository/wishlist_remote_repository.dart/wishlist_remote_repository.dart';
import 'package:home_rental/features/wishlist/presentation/widget/wishlist_list.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class GetWishlist extends StatefulWidget {
  const GetWishlist(
      {super.key,
      required List<PropertyApiModel> favoriteProperties,
      required WishlistRemoteRepository wishlistRepository,
      required String username});

  @override
  _GetWishlistState createState() => _GetWishlistState();
}

class _GetWishlistState extends State<GetWishlist> {
  int _selectedIndex = 1;

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GetBooking()),
      );
    } else if (index == 3) {
      final dio = Dio();
      final prefs = await SharedPreferences.getInstance();

      final profileRemoteDatasource = ProfileRemoteDatasource(dio, prefs);
      final profileRemoteRepository =
          ProfileRemoteRepository(profileRemoteDatasource, dio, prefs);
      final fetchUserUsecase = FetchUserUsecase(profileRemoteRepository);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProfilePage(fetchUserUsecase: fetchUserUsecase)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Wishlist'),
        ),
        body: const WishlistList(),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ));
  }
}
