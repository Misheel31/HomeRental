import 'package:flutter/material.dart';
import 'package:home_rental/screen/favorites.dart';
import 'package:home_rental/screen/feature_detail_screen.dart';
import 'package:home_rental/screen/feature_search.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  // Dummy data for features
  final List<Map<String, String>> features = [
    {"title": "Feature 1", "image": "assets/images/onboarding1.webp"},
    {"title": "Feature 2", "image": "assets/images/image1.png"},
    {"title": "Feature 3", "image": "assets/images/onboarding3.png"},
    {"title": "Feature 4", "image": "assets/images/image2.png"},
    {"title": "Feature 5", "image": "assets/images/splashscreen.webp"},
    {"title": "Feature 6", "image": "assets/images/image.png"},
  ];

  final Set<int> _favoriteIndices = {};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
      ),
      body: _selectedIndex == 0
          ? Column(
              children: [
                _buildSearchBox(),
                Expanded(child: _buildFeatureGrid()),
              ],
            )
          : Favorites(
              favoriteIndices: _favoriteIndices,
              features: features,
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
        backgroundColor: Colors.blueAccent,
        elevation: 10,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  // Enhanced Search Box
  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          decoration: InputDecoration(
            hintText: 'Search for features...',
            prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  // Enhanced Feature Grid with Vibrant Colors
  Widget _buildFeatureGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) {
          final feature = features[index];
          final isFavorite = _favoriteIndices.contains(index);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeatureDetailScreen(
                      title: "Living Room",
                      image: "assets/images/image.png",
                      description:
                          "A lovely property with 4 bedrooms and a private pool."),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
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
                          Colors.black.withOpacity(0.3),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  // Feature Title
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        feature['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            if (isFavorite) {
                              _favoriteIndices.remove(index);
                            } else {
                              _favoriteIndices.add(index);
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
}
