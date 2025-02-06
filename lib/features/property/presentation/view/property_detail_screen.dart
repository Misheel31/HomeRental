// import 'dart:convert';

// import 'package:date_picker_timeline/date_picker_timeline.dart';
// import 'package:flutter/material.dart';
// import 'package:home_rental/features/property/data/model/property_api_model.dart';
// import 'package:http/http.dart' as http;

// class PropertyDetailsScreen extends StatefulWidget {
//   final String propertyId;

//   const PropertyDetailsScreen({super.key, required this.propertyId});

//   @override
//   _PropertyDetailsScreenState createState() => _PropertyDetailsScreenState();
// }

// class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
//   late Future<PropertyApiModel> _propertyDetails;
//   DateTime? startDate;
//   DateTime? endDate;
//   int guestCount = 1;
//   bool isDescriptionExpanded = false;

//   @override
//   void initState() {
//     super.initState();
//     _propertyDetails = fetchPropertyDetails(widget.propertyId);
//   }

//   Future<PropertyApiModel> fetchPropertyDetails(String propertyId) async {
//     final response = await http.get(
//         Uri.parse('http://10.0.2.2:3000/api/property/properties/$propertyId'));

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = jsonDecode(response.body);

//       if (data.isNotEmpty) {
//         return PropertyApiModel.fromJson(data);
//       } else {
//         throw Exception('No data available');
//       }
//     } else {
//       throw Exception('Failed to load property details');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Property Details'),
//       ),
//       body: SingleChildScrollView(
//         child: FutureBuilder<PropertyApiModel>(
//           future: _propertyDetails,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData) {
//               return const Center(child: Text('No data available'));
//             }

//             final property = snapshot.data!;
//             final amenities = [
//               'Outdoor kitchen',
//               'Wi-fi',
//               'Pets allowed',
//               'Air conditioning',
//               'Parking available',
//               'Washing machine',
//             ];

//             // Initially show only the first half of the description
//             final descriptionToShow = isDescriptionExpanded
//                 ? property.description
//                 : (property.description.length > 100
//                     ? '${property.description.substring(0, 100)}...'
//                     : property.description);

//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 250,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount:
//                           property.image is List ? property.image.length : 1,
//                       itemBuilder: (context, index) {
//                         String image = property.image is List
//                             ? property.image[index]
//                             : property.image;

//                         if (!image.startsWith('http')) {
//                           image = 'http://10.0.2.2:3000/property_images/$image';
//                         }

//                         image = Uri.encodeFull(image);

//                         return Image.network(
//                           image,
//                           fit: BoxFit.cover,
//                           width: MediaQuery.of(context).size.width,
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     property.title,
//                     style: const TextStyle(
//                         fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(property.location),
//                   const SizedBox(height: 10),

//                   // Description with "Read More" functionality
//                   Text(
//                     descriptionToShow,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 10),
//                   TextButton(
//                     onPressed: () {
//                       setState(() {
//                         isDescriptionExpanded = !isDescriptionExpanded;
//                       });
//                     },
//                     child: Text(
//                       isDescriptionExpanded ? 'Read Less' : 'Read More',
//                       style: const TextStyle(color: Colors.blue),
//                     ),
//                   ),

//                   const SizedBox(height: 20),
//                   const Text(
//                     'Amenities',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Wrap(
//                     spacing: 8.0,
//                     children: amenities
//                         .map((amenity) => Chip(label: Text(amenity)))
//                         .toList(),
//                   ),
//                   const SizedBox(height: 5),

//                   // Date selection
//                   const Text(
//                     'Select Dates',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 100,
//                     child: DatePicker(
//                       DateTime.now(),
//                       initialSelectedDate: DateTime.now(),
//                       selectionColor: Colors.amber,
//                       selectedTextColor: Colors.white,
//                       onDateChange: (date) {
//                         setState(() {
//                           startDate = date;
//                         });
//                       },
//                     ),
//                   ),

//                   const SizedBox(height: 10),
//                   const Text(
//                     'Guests',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             guestCount = (guestCount > 1) ? guestCount - 1 : 1;
//                           });
//                         },
//                         icon: const Icon(Icons.remove),
//                       ),
//                       Text('$guestCount'),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             guestCount =
//                                 (guestCount < 10) ? guestCount + 1 : 10;
//                           });
//                         },
//                         icon: const Icon(Icons.add),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),

//                   ElevatedButton(
//                     onPressed: () {
//                       print("Book now clicked for ${property.title}");
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       backgroundColor: Colors.amber,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text('Book Now'),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';
import 'package:home_rental/features/property/presentation/widget/amenities_section.dart';
import 'package:home_rental/features/property/presentation/widget/book_button.dart';
import 'package:home_rental/features/property/presentation/widget/date_picker_widget.dart';
import 'package:home_rental/features/property/presentation/widget/guest_selector.dart';
import 'package:home_rental/features/property/presentation/widget/property_image_carousel.dart';
import 'package:http/http.dart' as http;

class PropertyDetailsScreen extends StatefulWidget {
  final String propertyId;

  const PropertyDetailsScreen({super.key, required this.propertyId});

  @override
  _PropertyDetailsScreenState createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  late Future<PropertyApiModel> _propertyDetails;
  DateTime? startDate;
  DateTime? endDate;
  int guestCount = 1;

  @override
  void initState() {
    super.initState();
    _propertyDetails = fetchPropertyDetails(widget.propertyId);
  }

  Future<PropertyApiModel> fetchPropertyDetails(String propertyId) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/property/properties/$propertyId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data.isNotEmpty) {
        return PropertyApiModel.fromJson(data);
      } else {
        throw Exception('No data available');
      }
    } else {
      throw Exception('Failed to load property details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<PropertyApiModel>(
          future: _propertyDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            final property = snapshot.data!;
            final amenities = [
              'Outdoor kitchen',
              'Wi-fi',
              'Pets allowed',
              'Air conditioning',
              'Parking available',
              'Washing machine',
            ];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PropertyImageCarousel(property: property),
                  const SizedBox(height: 10),
                  Text(
                    property.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(property.location),
                  const SizedBox(height: 10),
                  Text(property.description),
                  const SizedBox(height: 20),
                  AmenitiesSection(amenities: amenities),
                  const SizedBox(height: 10),
                  const Text(
                    'Select Dates',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DatePickerWidget(
                    selectedDate: startDate,
                    onDateChange: (date) {
                      setState(() {
                        startDate = date;
                      });
                    },
                  ),
                  const Text(
                    'Guests',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GuestSelector(
                    guestCount: guestCount,
                    onIncrease: (count) {
                      setState(() {
                        guestCount = (guestCount < 10) ? guestCount + 1 : 10;
                      });
                    },
                    onDecrease: (count) {
                      setState(() {
                        guestCount = (guestCount > 1) ? guestCount - 1 : 1;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  BookButton(
                    onPressed: () {
                      // Handle booking
                      print("Book now clicked for ${property.title}");
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
