import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:home_rental/features/booking/presentation/view/get_booking.dart';
import 'package:home_rental/features/home/presentation/widget/bottom_navigation_bar.dart';
import 'package:home_rental/features/home/presentation/widget/custom_app_bar.dart';
import 'package:home_rental/features/home/presentation/widget/location_search.dart';
import 'package:home_rental/features/home/presentation/widget/price_filter.dart';
import 'package:home_rental/features/home/presentation/widget/property_card.dart';
import 'package:home_rental/features/profile/data/data_source/remote_datasource/profile_remote_datasource.dart';
import 'package:home_rental/features/profile/data/repository/profile_remote_repository/profile_remote_repository.dart';
import 'package:home_rental/features/profile/domain/use_case/fetch_user_usecase.dart';
import 'package:home_rental/features/profile/presentation/view/profile_view.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';
import 'package:home_rental/features/wishlist/data/data_source/remote_data_source/wishlist_remote_datasource.dart';
import 'package:home_rental/features/wishlist/data/repository/wishlist_remote_repository.dart/wishlist_remote_repository.dart';
import 'package:home_rental/features/wishlist/presentation/view/wishlist_view.dart';
import 'package:http/http.dart' as http;
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Set<PropertyApiModel> favoriteProperties = {};
  List<PropertyApiModel> properties = [];
  List<PropertyApiModel> filteredProperties = [];
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  bool _isLoading = false;
  static const double shakeThreshold = 15.0;
  AccelerometerEvent? _lastEvent;

  double minPrice = 0.0;
  double maxPrice = 10000.0;

  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProperties();
    _startShakeListener();

    _minPriceController.text = minPrice.toString();
    _maxPriceController.text = maxPrice.toString();
  }

  Future<void> _fetchProperties() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.70:3000/api/property/properties'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          properties = data.map((json) {
            if (json['image'] != null) {
              String image = json['image'].trim();
              if (!image.startsWith('http')) {
                image = 'http://192.168.1.70:3000/property_images/$image';
              }
              json['image'] = Uri.encodeFull(image);
            }
            return PropertyApiModel.fromJson(json);
          }).toList();
          _applyFilters();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load properties');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching properties: $error');
    }
  }

  void _applyFilters() {
    setState(() {
      filteredProperties = properties.where((property) {
        bool priceFilter = property.pricePerNight >= minPrice &&
            property.pricePerNight <= maxPrice;

        bool locationFilter = property.location
            .toLowerCase()
            .contains(_locationController.text.toLowerCase());

        return priceFilter && locationFilter;
      }).toList();
    });
  }

  void _startShakeListener() {
    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      if (_lastEvent != null) {
        double deltaX = event.x - _lastEvent!.x;
        double deltaY = event.y - _lastEvent!.y;
        double deltaZ = event.z - _lastEvent!.z;

        double acceleration =
            sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ);

        if (acceleration > shakeThreshold) {
          _onShakeDetected();
        }
      }
      _lastEvent = event;
    });
  }

  void _onShakeDetected() {
    if (!_isLoading) {
      _fetchProperties();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Refreshing properties...')),
      );
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username') ?? 'misheel';
      final dio = Dio();
      final remoteDataSouce = WishlistRemoteDatasource(dio: Dio());
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Favorites(
                  favoriteProperties: favoriteProperties.toList(),
                  wishlistRepository: WishlistRemoteRepository(
                      remoteDatasource: remoteDataSouce),
                  username: username,
                )),
      );
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
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;

    return Scaffold(
      appBar: CustomAppBar(
        isTablet: isTablet,
        title: ('Rentify'),
        actions: [
          LocationSearch(
            locationController: _locationController,
            onLocationChanged: (value) {
              setState(() {
                // Trigger re-filtering on location change
              });
              _applyFilters();
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.add),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => const CreatePropertyScreen()),
          //     );
          //   },
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            PriceFilter(
              minPriceController: _minPriceController,
              maxPriceController: _maxPriceController,
              onMinPriceChanged: (value) {
                setState(() {
                  minPrice = double.tryParse(value) ?? 0.0;
                });
                _applyFilters();
              },
              onMaxPriceChanged: (value) {
                setState(() {
                  maxPrice = double.tryParse(value) ?? 10000.0;
                });
                _applyFilters();
              },
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredProperties.isEmpty
                      ? const Center(
                          child: Text('No properties found for the filters.'))
                      : ListView.builder(
                          itemCount: filteredProperties.length,
                          itemBuilder: (context, index) {
                            final property = filteredProperties[index];
                            return PropertyCard(
                              property: property,
                              onFavoritePressed: () {
                                setState(() {
                                  if (favoriteProperties.contains(property)) {
                                    favoriteProperties.remove(property);
                                  } else {
                                    favoriteProperties.add(property);
                                  }
                                });
                              },
                              onDeletePressed: () async {
                                try {
                                  final response = await http.delete(
                                    Uri.parse(
                                        'http://192.168.1.70:3000/api/property/properties/${property.id}'),
                                  );

                                  if (response.statusCode == 200) {
                                    setState(() {
                                      properties.removeWhere(
                                          (item) => item.id == property.id);
                                      _applyFilters();
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Property deleted successfully')));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Failed to delete property: ${response.body}'),
                                    ));
                                  }
                                } catch (error) {
                                  print('Error deleting property: $error');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'An error occurred while deleting the property')));
                                }
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
