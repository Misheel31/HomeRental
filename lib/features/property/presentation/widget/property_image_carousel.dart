import 'package:flutter/material.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';

class PropertyImageCarousel extends StatelessWidget {
  final PropertyApiModel property;

  const PropertyImageCarousel({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: property.image is List ? property.image.length : 1,
        itemBuilder: (context, index) {
          String image =
              property.image is List ? property.image[index] : property.image;

          if (!image.startsWith('http')) {
            image = 'http://192.168.1.70:3000/property_images/$image';
          }

          image = Uri.encodeFull(image);

          return Image.network(
            image,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          );
        },
      ),
    );
  }
}
