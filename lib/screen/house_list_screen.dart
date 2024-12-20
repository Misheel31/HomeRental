import 'package:flutter/material.dart';

class HouseListScreen extends StatelessWidget {
  const HouseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> houses = [
      {"title": "Modern Apartment", "image": "assets/images/image1.png"},
      {"title": "Luxury Villa", "image": "assets/images/image2.png"},
      {"title": "Beach House", "image": "assets/images/beachHouse.jpeg"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Houses'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: houses.length,
        itemBuilder: (context, index) {
          final house = houses[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.asset(house['image']!, width: 50, height: 50),
              title: Text(house['title']!),
              onTap: () {
                // Add navigation to house detail if needed
              },
            ),
          );
        },
      ),
    );
  }
}
