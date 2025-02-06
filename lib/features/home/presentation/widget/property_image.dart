import 'package:flutter/material.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';

class PropertyImage extends StatelessWidget {
  final PropertyApiModel property;

  const PropertyImage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
      child: Image.network(
        property.image,
        fit: BoxFit.cover,
        height: 200,
        width: double.infinity,
      ),
    );
  }
}
