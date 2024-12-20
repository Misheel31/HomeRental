import 'package:flutter/material.dart';
import 'package:home_rental/screen/favorites.dart';
import 'package:home_rental/screen/feature_detail_screen.dart';
import 'package:home_rental/screen/feature_search.dart';
import 'package:home_rental/screen/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // Dummy data for features
  final List<Map<String, String>> features = [
    {
      "title": "Skyline Vista Appartment",
      "image": "assets/images/onboarding1.webp",
      "price": "\$1200",
      "location": "London, UK",
      "description":
          "Luxurious high-rise apartment with stunning city view, modern amities"
    },
    {
      "title": "Austin Oasis Lofts",
      "image": "assets/images/image1.png",
      "price": "\$1500",
      "location": "Rome, Italy",
      "description":
          "Contemporary loft space with industrial touches, perfect for young professional in trendy East Austin"
    },
    {
      "title": "Pacific Heights Haven",
      "image": "assets/images/images3.avif",
      "price": "\$900",
      "location": "Lisbon, Portugal",
      "description":
          "Victorain-style apartment featuring bay windows, hardwood floors, and classic Franciso charm"
    },
    {
      "title": "Emerald City Residences",
      "image": "assets/images/image2.png",
      "price": "\$1100",
      "location": "Hamburg, Germany",
      "description":
          "Eco-friendly apartment with panoramic mountain view and state-of-the-art smart home features"
    },
    {
      "title": "Millennium Park Suites",
      "image": "assets/images/splashscreen.webp",
      "price": "\$1700",
      "location": "NEw York, USA",
      "description":
          "Elegant downtown apartment offering breathtaking views of Millennium Park and Lake Michigan"
    },
    {
      "title": "Venice Beach Studio",
      "image": "assets/images/beachHouse.jpeg",
      "price": "\$1300",
      "location": "Chicago, USA",
      "description":
          "Bright and airy studio apartment steps from Venice Beach, featuring modern coastal design"
    },
    {
      "title": "Admire Vatican Views from a Room in a Bright Home ",
      "image": "assets/images/images.jpg",
      "price": "\$1300",
      "location": "Paris, France",
      "description":
          "Double room available in an immaculate 2 bed tenement flat in Dennistoun. Comfy double bed with storage in room. "
    },
    {
      "title": "Pet friendly double room ",
      "image": "assets/images/image.png",
      "price": "\$1300",
      "location": "Paris, France",
      "description":
          "The Room is extremely private, with a plunge pool on its doorstep, large communal pool and the Indian Ocean only 20 meters away with white sandy beach."
    }
  ];

  final Set<int> _favoriteIndices = {};
  String? _selectedCity;
  String? _selectedPriceRange;

  final List<String> cities = [
    "New York",
    "San Francisco",
    "Austin",
    "Los Angeles",
    "Seatlle",
    "Chicago"
  ];

  final List<String> priceRanges = ["\$500", "\$1000", "\$1200", "\$1100"];

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rentify',
          style: TextStyle(
            fontSize: isTablet ? 24 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        elevation: 5,
        shadowColor: Colors.grey.withOpacity(0.5),
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              size: isTablet ? 28 : 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? Column(
              children: [
                _buildSearchBox(isTablet),
                const SizedBox(height: 10),
                // _buildFilterChips(),
                Expanded(child: _buildFeatureGrid(isTablet)),
              ],
            )
          : Favorites(
              favoriteIndices: _favoriteIndices,
              features: features,
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, size: isTablet ? 28 : 24),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: isTablet ? 28 : 24),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: isTablet ? 28 : 24),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
        backgroundColor: Colors.blueAccent,
        elevation: 10,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat Bold',
          fontSize: isTablet ? 16 : 14,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: isTablet ? 14 : 12,
        ),
      ),
    );
  }

  // Search Box with enhanced UI
  Widget _buildSearchBox(bool isTablet) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24 : 12,
        vertical: isTablet ? 16 : 8,
      ),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onTap: () {
            showSearch(
              context: context,
              delegate: FeatureSearch(features),
            );
          },
          readOnly: true,
          style: TextStyle(fontSize: isTablet ? 18 : 16),
          decoration: InputDecoration(
              hintText: 'Search for properties...',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.blueAccent,
                size: isTablet ? 28 : 24,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: isTablet ? 16 : 12,
                horizontal: isTablet ? 20 : 16,
              )),
        ),
      ),
    );
  }

  // Filter Chips Row
  // Widget _buildFilterChips() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       FilterChip(
  //         label: const Text('House'),
  //         onSelected: (_) {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => const HouseListScreen()),
  //           );
  //         },
  //         backgroundColor: Colors.grey[200],
  //         selectedColor: Colors.blueAccent.withOpacity(0.2),
  //       ),
  //       FilterChip(
  //         label: const Text('City'),
  //         onSelected: (_) {},
  //         backgroundColor: Colors.grey[200],
  //         selectedColor: Colors.blueAccent.withOpacity(0.2),
  //       ),
  //       FilterChip(
  //         label: const Text('Price Range'),
  //         onSelected: (_) {},
  //         backgroundColor: Colors.grey[200],
  //         selectedColor: Colors.blueAccent.withOpacity(0.2),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildCityDropdown() {
    return ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cities[index]),
            onTap: () {
              setState(() {
                _selectedCity = cities[index];
              });
              Navigator.pop(context);
            },
          );
        });
  }

  Widget _buildPriceDropdown() {
    return ListView.builder(
        itemCount: priceRanges.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(priceRanges[index]),
            onTap: () {
              setState(() {
                _selectedPriceRange = priceRanges[index];
              });
              Navigator.pop(context);
            },
          );
        });
  }

  // Feature Grid with vibrant design
  Widget _buildFeatureGrid(bool isTablet) {
    final filteredFeatures = features.where((feature) {
      final matchesCity =
          _selectedCity == null || feature['location'] == _selectedCity;
      final matchesPrice =
          _selectedPriceRange == null || _isPriceInRange(feature['price']!);
      return matchesCity && matchesPrice;
    }).toList();

    final crossAxisCount = isTablet ? 4 : 2;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24.0 : 16.0,
        vertical: isTablet ? 16.0 : 12.0,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: isTablet ? 20 : 16,
          mainAxisSpacing: isTablet ? 20 : 16,
          childAspectRatio: isTablet ? 0.85 : 0.75,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) {
          final feature = filteredFeatures[index];
          final isFavorite =
              _favoriteIndices.contains(features.indexOf(feature));

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeatureDetailScreen(
                    title: feature['title']!,
                    image: feature['image']!,
                    description:
                        "${feature['title']} located in ${feature['location']} at a price of ${feature['price']}.",
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
              ),
              elevation: 5,
              shadowColor: Colors.black26,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // Feature Image
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(feature['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  // Feature Title
                  Positioned(
                    bottom: isTablet ? 12 : 8,
                    left: isTablet ? 12 : 8,
                    right: isTablet ? 12 : 8,
                    child: Column(
                      children: [
                        Text(
                          feature['title']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: isTablet ? 16 : 14,
                          ),
                          // textAlign: TextAlign.center,
                        ),
                        Text(
                          feature['price']!,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isTablet ? 14 : 12,
                          ),
                          // textAlign: TextAlign.end,
                        ),
                        Text(
                          feature['location']!,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isTablet ? 14 : 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  // Favorite Button
                  Positioned(
                    top: isTablet ? 12 : 8,
                    right: isTablet ? 12 : 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: isTablet ? 20 : 16,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: isTablet ? 24 : 20,
                        ),
                        onPressed: () {
                          setState(() {
                            if (isFavorite) {
                              _favoriteIndices
                                  .remove(features.indexOf(feature));
                            } else {
                              _favoriteIndices.add(features.indexOf(feature));
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isPriceInRange(String price) {
    final priceValue = int.parse(price.replaceAll('\$', ''));
    switch (_selectedPriceRange) {
      case "\$500 - \$1000":
        return priceValue >= 500 && priceValue <= 1000;
      case "\$1001 - \$1500":
        return priceValue > 1000 && priceValue <= 1500;
      case "\$1501 - \$2000":
        return priceValue > 1500 && priceValue <= 2000;
      case "Above \$2000":
        return priceValue > 2000;
      default:
        return true;
    }
  }
}
