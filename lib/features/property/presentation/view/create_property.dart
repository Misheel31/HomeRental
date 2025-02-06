import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class CreatePropertyScreen extends StatefulWidget {
  const CreatePropertyScreen({super.key});

  @override
  _CreatePropertyScreenState createState() => _CreatePropertyScreenState();
}

class _CreatePropertyScreenState extends State<CreatePropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String location = '';
  double pricePerNight = 0.0;
  double bedCount = 0.0;
  double bedroomCount = 0.0;
  bool available = true;
  double bathroomCount = 0.0;
  String city = '';
  String state = '';
  String country = '';
  double guestCount = 0.0;
  String image = '';
  List<String> amenities = [];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      String fileExtension = pickedFile.path.split('.').last.toLowerCase();
      if (['jpg', 'jpeg', 'png', 'avif'].contains(fileExtension)) {
        setState(() {
          image = pickedFile.path;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Invalid file type. Only JPEG, PNG, JPG, and AVIF are allowed.')));
      }
    }
  }

  Future<void> uploadImage(File imageFile) async {
    var uri = Uri.parse('http://10.0.2.2:3000/api/property/properties/create');

    var request = http.MultipartRequest('POST', uri);

    var image = await http.MultipartFile.fromPath(
      'property_images',
      imageFile.path,
      contentType: MediaType('image', 'jpg'),
    );
    request.files.add(image);

    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['location'] = location;
    request.fields['pricePerNight'] = pricePerNight.toString();
    request.fields['bedCount'] = bedCount.toString();
    request.fields['bedroomCount'] = bedroomCount.toString();
    request.fields['available'] = available.toString();
    request.fields['bathroomCount'] = bathroomCount.toString();
    request.fields['state'] = state;
    request.fields['city'] = city;
    request.fields['country'] = country;
    request.fields['guestCount'] = guestCount.toString();
    request.fields['amenities'] = amenities.join(',');

    var response = await request.send();

    if (response.statusCode == 201) {
      print('Property created successfully!');
    } else {
      print('Failed to create property. Status code: ${response.statusCode}');
    }
  }

  Future<void> _createProperty() async {
    if (image.isNotEmpty) {
      await uploadImage(File(image));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Property'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) {
                  title = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  description = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                onSaved: (value) {
                  location = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price per night'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  pricePerNight = double.tryParse(value ?? '0.0') ?? 0.0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bed Count'),
                onSaved: (value) {
                  bedCount = double.tryParse(value ?? '0.0') ?? 0.0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the bed count';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bedroom Count'),
                onSaved: (value) {
                  bedroomCount = double.tryParse(value ?? '0.0') ?? 0.0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the bedroom count';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: const Text('Available'),
                value: available,
                onChanged: (value) {
                  setState(() {
                    available = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Amenities (comma separated)'),
                onSaved: (value) {
                  amenities = value?.split(',') ?? [];
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Guest Count'),
                onSaved: (value) {
                  guestCount = double.tryParse(value ?? '0.0') ?? 0.0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the guest count';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bathroom Count'),
                onSaved: (value) {
                  bathroomCount = double.tryParse(value ?? '0.0') ?? 0.0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the bathroom count';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'City'),
                onSaved: (value) {
                  city = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'State'),
                onSaved: (value) {
                  state = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a state';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Country'),
                onSaved: (value) {
                  country = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a country';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Image'),
              ),
              if (image.isNotEmpty)
                Image.file(File(image),
                    height: 200, width: 200, fit: BoxFit.cover),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _createProperty();
                  }
                },
                child: const Text('Create Property'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
