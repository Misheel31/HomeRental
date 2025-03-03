import 'package:flutter/material.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';
import 'package:home_rental/features/property/presentation/view/property_detail_screen.dart';

class PropertyCard extends StatelessWidget {
  final PropertyApiModel property;
  final VoidCallback onFavoritePressed;
  final VoidCallback onDeletePressed;

  const PropertyCard({
    super.key,
    required this.property,
    required this.onFavoritePressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return GestureDetector(
      onTap: () {
        if (property.id != null && property.id!.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PropertyDetailsScreen(propertyId: property.id ?? ''),
            ),
          );
        } else {
          print("Invalid property ID");
        }
      },
      child: Card(
        margin: EdgeInsets.all(isTablet ? 16.0 : 8.0),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isTablet ? 16.0 : 12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: isTablet ? 300 : 180,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isTablet ? 16.0 : 12.0),
                      topRight: Radius.circular(isTablet ? 16.0 : 12.0),
                    ),
                    child: Image.network(
                      property.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: isTablet ? 18 : 16,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: isTablet ? 22 : 18,
                          ),
                          onPressed: onFavoritePressed,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // CircleAvatar(
                      //   backgroundColor: Colors.white,
                      //   radius: isTablet ? 18 : 16,
                      //   child: IconButton(
                      //     icon: Icon(
                      //       Icons.delete,
                      //       color: Colors.grey[700],
                      //       size: isTablet ? 22 : 18,
                      //     ),
                      //     onPressed: () {
                      //       showDialog(
                      //         context: context,
                      //         builder: (BuildContext context2) {
                      //           return AlertDialog(
                      //             title: const Text('Delete Property'),
                      //             content: Text(
                      //                 'Are you sure you want to delete "${property.title}"?'),
                      //             actions: [
                      //               TextButton(
                      //                 child: const Text('Cancel'),
                      //                 onPressed: () {
                      //                   Navigator.of(context2).pop();
                      //                 },
                      //               ),
                      //               TextButton(
                      //                 child: const Text('Delete'),
                      //                 onPressed: () {
                      //                   onDeletePressed();
                      //                   Navigator.of(context2).pop();
                      //                 },
                      //               ),
                      //             ],
                      //           );
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(isTablet ? 16.0 : 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    style: TextStyle(
                      fontSize: isTablet ? 18 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[600],
                        size: isTablet ? 16 : 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        property.location,
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Price per night: \$${property.pricePerNight}',
                    style: TextStyle(
                      fontSize: isTablet ? 16 : 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
