import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  final Set<int> favoriteIndices;
  final List<Map<String, String>> features;

  const Favorites({
    super.key,
    required this.favoriteIndices,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteFeatures =
        favoriteIndices.map((index) => features[index]).toList();

    return favoriteFeatures.isEmpty
        ? const Center(child: Text('No favorites added yet.'))
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 images per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8, // Adjust height
              ),
              itemCount: favoriteFeatures.length,
              itemBuilder: (context, index) {
                final feature = favoriteFeatures[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black26,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            feature['image']!,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feature['location']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              feature['price']!,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
