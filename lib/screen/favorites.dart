import 'package:flutter/material.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';

class Favorites extends StatelessWidget {
  final List<PropertyApiModel> favoriteProperties;

  const Favorites({super.key, required this.favoriteProperties});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteProperties.isEmpty
          ? const Center(
              child: Text('No favorites yet!'),
            )
          : ListView.builder(
              itemCount: favoriteProperties.length,
              itemBuilder: (context, index) {
                final property = favoriteProperties[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      property.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(property.title),
                    subtitle: Text('Location: ${property.location}'),
                  ),
                );
              },
            ),
    );
  }
}
