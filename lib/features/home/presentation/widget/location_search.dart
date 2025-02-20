import 'package:flutter/material.dart';

class LocationSearch extends StatelessWidget {
  final TextEditingController locationController;
  final Function(String) onLocationChanged;

  const LocationSearch({
    super.key,
    required this.locationController,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 200,
        height: 40,
        child: TextField(
          controller: locationController,
          decoration: InputDecoration(
            labelText: 'Search by location',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blueAccent),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          onChanged: onLocationChanged,
        ),
      ),
    );
  }
}
