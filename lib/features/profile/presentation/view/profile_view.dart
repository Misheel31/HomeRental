import 'dart:async';

import 'package:dartz/dartz.dart' as dartz;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/booking/presentation/view/get_booking.dart';
import 'package:home_rental/features/home/presentation/view/home_view.dart';
import 'package:home_rental/features/home/presentation/widget/bottom_navigation_bar.dart';
import 'package:home_rental/features/profile/domain/entity/user_entity.dart';
import 'package:home_rental/features/profile/domain/use_case/fetch_user_usecase.dart';
import 'package:home_rental/features/profile/presentation/widget/profile_header.dart';
import 'package:home_rental/features/profile/presentation/widget/profile_image_picker.dart';
import 'package:home_rental/features/profile/presentation/widget/profile_option.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';
import 'package:home_rental/features/wishlist/data/data_source/remote_data_source/wishlist_remote_datasource.dart';
import 'package:home_rental/features/wishlist/data/repository/wishlist_remote_repository.dart/wishlist_remote_repository.dart';
import 'package:home_rental/features/wishlist/presentation/view/wishlist_view.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final FetchUserUsecase fetchUserUsecase;

  const ProfilePage({super.key, required this.fetchUserUsecase});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences prefs;
  int _currentIndex = 3;
  Set<PropertyApiModel> favoriteProperties = {};
  late StreamSubscription _proximitySubscription;
  bool _isDarkMode = false;
  // bool _prefsInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
    _loadThemePreference();

    _proximitySubscription = ProximitySensor.events.listen((event) {
      print("Proximity event: $event");
      if (event > 0) {
        _toggleTheme(true);
      } else {
        _toggleTheme(false);
      }
    });
  }

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
    _saveThemePreference();
  }

  Future<void> _saveThemePreference() async {
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  Future<void> _loadThemePreference() async {
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  @override
  void dispose() {
    _proximitySubscription.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }

    if (index == 1) {
      final username = prefs.getString('username') ?? 'Guest';
      final remoteDataSource = WishlistRemoteDatasource(dio: Dio());
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GetWishlist(
                  favoriteProperties: favoriteProperties.toList(),
                  wishlistRepository: WishlistRemoteRepository(
                      remoteDatasource: remoteDataSource),
                  username: username,
                )),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GetBooking()),
      );
    } else if (index == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProfilePage(fetchUserUsecase: widget.fetchUserUsecase)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: FutureBuilder<dartz.Either<Failure, UserEntity>>(
          future: widget.fetchUserUsecase.getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            final result = snapshot.data!;

            return result.fold(
              (failure) => Center(child: Text('Error: ${failure.message}')),
              (user) => SingleChildScrollView(
                child: Column(
                  children: [
                    const ProfileImagePicker(),
                    ProfileHeader(username: user.username),
                    const ProfileOptions(),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _currentIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
