import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/features/booking/presentation/view/create_booking_view.dart';
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
        Uri.parse('${ApiEndpoints.baseUrl}property/properties/$propertyId'));

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
            final amenities = property.amenities
                // 'Outdoor kitchen',
                // 'Wi-fi',
                // 'Pets allowed',
                // 'Air conditioning',
                // 'Parking available',
                // 'Washing machine',
                ;

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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateBookingView(
                                    propertyId: property.id ?? '',
                                  )));
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
