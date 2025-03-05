import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
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
import 'package:proximity_sensor/proximity_sensor.dart';
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

  late StreamSubscription _proximitySubscription;
  bool _isDarkMode = false;

  double minPrice = 0.0;
  double maxPrice = 10000.0;

  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _fetchProperties();
    _startShakeListener();
    _initializePrefs();

    _minPriceController.text = minPrice.toString();
    _maxPriceController.text = maxPrice.toString();
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

  Future<void> _fetchProperties() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.getAllProperties}'),
      );

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
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Refreshing properties...')),
      // );
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    _locationController.dispose();
    _proximitySubscription.cancel();
    super.dispose();
  }

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username') ?? 'misheel';
      final remoteDataSouce = WishlistRemoteDatasource(dio: Dio());
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GetWishlist(
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

    return MaterialApp(
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: Scaffold(
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "List of Properties",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
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
                                onFavoritePressed: () async {
                                  setState(() {
                                    favoriteProperties.add(property);
                                  });
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  final username =
                                      prefs.getString('username') ?? 'misheel';
                                  try {
                                    final response = await http.post(
                                      Uri.parse(
                                        '${ApiEndpoints.baseUrl}${ApiEndpoints.addToWishlist}',
                                      ),
                                      headers: {
                                        'Content-Type': 'application/json'
                                      },
                                      body: json.encode({
                                        'username': username,
                                        'propertyId': property.id,
                                        'title': property.title,
                                        'location': property.location,
                                        'image': property.image,
                                        'pricePerNight': property.pricePerNight,
                                      }),
                                    );

                                    if (response.statusCode == 201) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text('Property added to wishlist'),
                                        backgroundColor: Colors.green,
                                      ));
                                      print('Property added to wishlist');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Failed to add property')),
                                      );
                                      print(
                                          'Failed to add property to wishlist: ${response.body}');
                                    }
                                  } catch (e) {
                                    print(
                                        'Error adding property to wishlist: $e');
                                  }
                                },
                                onDeletePressed: () {},
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          onItemTapped: _onItemTapped,
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }
}
