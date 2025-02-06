import 'package:flutter/material.dart';

class AmenitiesSection extends StatelessWidget {
  final List<String> amenities;

  const AmenitiesSection({super.key, required this.amenities});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amenities',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          children:
              amenities.map((amenity) => Chip(label: Text(amenity))).toList(),
        ),
      ],
    );
  }
}
