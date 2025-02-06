import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/features/home/presentation/widget/bottom_navigation_bar.dart';
import 'package:home_rental/features/home/presentation/widget/custom_app_bar.dart';
import 'package:home_rental/features/home/presentation/widget/property_card.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';
import 'package:home_rental/features/property/presentation/view/create_property.dart';
import 'package:home_rental/screen/favorites.dart';
import 'package:home_rental/screen/profile_screen.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Set<PropertyApiModel> favoriteProperties = {};

  Future<List<PropertyApiModel>> fetchProperties() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:3000/api/property/properties'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) {
        if (json['image'] != null) {
          String image = json['image'].trim();
          if (!image.startsWith('http')) {
            image = 'http://10.0.2.2:3000/property_images/$image';
          }
          json['image'] = Uri.encodeFull(image);
        }
        return PropertyApiModel.fromJson(json);
      }).toList();
    } else {
      throw Exception('Failed to load properties');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Favorites(
                  favoriteProperties: favoriteProperties.toList(),
                )),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
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
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreatePropertyScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<PropertyApiModel>>(
        future: fetchProperties(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No properties found.'));
          }

          final properties = snapshot.data!;

          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];
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
                          'http://10.0.2.2:3000/api/property/properties/${property.id}'),
                    );

                    if (response.statusCode == 200) {
                      setState(() {
                        properties
                            .removeWhere((item) => item.id == property.id);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Property deleted successfully')),
                      );
                    } else {
                      // Handle API failure
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Failed to delete property: ${response.body}')),
                      );
                    }
                  } catch (error) {
                    // Handle network or other errors
                    print('Error deleting property: $error');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'An error occurred while deleting the property')),
                    );
                  }
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
