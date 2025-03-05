import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/app/shared_prefs/token_shared_prefs.dart';
import 'package:home_rental/features/booking/presentation/widget/confirm_button.dart';
import 'package:home_rental/features/booking/presentation/widget/date_picker_field.dart';
import 'package:home_rental/features/booking/presentation/widget/guests_dropdown.dart';
import 'package:home_rental/features/booking/presentation/widget/total_price_display.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateBookingView extends StatefulWidget {
  final String propertyId;
  final DateTime? startDate;
  final DateTime? endDate;
  final int guestCount;

  const CreateBookingView(
      {super.key,
      required this.propertyId,
      this.startDate,
      this.endDate,
      required this.guestCount});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<CreateBookingView> {
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  int guests = 1;

  double totalPrice = 0.0;
  bool isLoading = false;
  bool isUsernameLoaded = false;

  String username = 'misheel';
  String token = '';
  double pricePerNight = 0.0;

  @override
  void initState() {
    super.initState();

    DateFormat format = DateFormat("yyyy-MM-dd");

    _startDateController = TextEditingController(
      text: widget.startDate != null ? format.format(widget.startDate!) : '',
    );

    _endDateController = TextEditingController(
      text: widget.endDate != null ? format.format(widget.endDate!) : '',
    );

    guests = widget.guestCount;
    _fetchUsername();
    _fetchToken();
    _fetchPropertyDetails();
  }

  Future<void> _fetchToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? '';
    });
  }

  Future<void> _fetchUsername() async {
    final tokenSharedPrefs =
        TokenSharedPrefs(await SharedPreferences.getInstance());
    final result = await tokenSharedPrefs.fetchUsername();
    result.fold(
      (failure) {
        setState(() {
          username = 'misheel';
          isUsernameLoaded = true;
        });
      },
      (fetchedUsername) {
        setState(() {
          username = fetchedUsername.isNotEmpty ? fetchedUsername : 'misheel';
          isUsernameLoaded = true;
        });
      },
    );
  }

  Future<void> _fetchPropertyDetails() async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiEndpoints.baseUrl}property/properties/${widget.propertyId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          pricePerNight = data['pricePerNight']?.toDouble() ?? 0.0;
        });
      }
    } catch (error) {
      print('Error fetching property details: $error');
    }
  }

  double _calculateTotalPrice() {
    if (_startDateController.text.isEmpty || _endDateController.text.isEmpty) {
      return 0.0;
    }

    DateFormat format = DateFormat("yyyy-MM-dd");
    DateTime? startDate = format.parse(_startDateController.text);
    DateTime? endDate = format.parse(_endDateController.text);

    if (startDate.isAfter(endDate)) {
      return 0.0;
    }

    int duration = endDate.difference(startDate).inDays;
    return (duration * pricePerNight * guests).toDouble();
  }

  Future<void> _submitBooking() async {
    if (!isUsernameLoaded || username.isEmpty || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in first.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoints.baseUrl}booking/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'startDate': _startDateController.text,
          'endDate': _endDateController.text,
          'totalPrice': _calculateTotalPrice(),
          'username': username,
          'propertyId': widget.propertyId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Booking confirmed!',
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking failed: ${response.body}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete your booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DatePickerField(
                label: 'Check-in Date',
                controller: _startDateController,
                onChanged: () => setState(() {
                  totalPrice = _calculateTotalPrice();
                }),
              ),
              const SizedBox(height: 16),
              DatePickerField(
                label: 'Check-out Date',
                controller: _endDateController,
                onChanged: () => setState(() {
                  totalPrice = _calculateTotalPrice();
                }),
              ),
              const SizedBox(height: 16),
              GuestsDropdown(
                guests: guests,
                onChanged: (value) {
                  setState(() {
                    guests = value!;
                    totalPrice = _calculateTotalPrice();
                  });
                },
              ),
              const SizedBox(height: 16),
              TotalPriceDisplay(totalPrice: totalPrice),
              const SizedBox(height: 24),
              ConfirmButton(
                isLoading: isLoading,
                isEnabled: isUsernameLoaded,
                onPressed: _submitBooking,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
