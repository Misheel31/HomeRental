import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:home_rental/features/booking/presentation/widget/booking_api_service.dart';
import 'package:home_rental/features/booking/presentation/widget/bookings_list_widgte.dart';
import 'package:home_rental/features/booking/presentation/widget/checkout_confirmation_page.dart';
import 'package:home_rental/features/home/presentation/view/home_view.dart';
import 'package:home_rental/features/home/presentation/widget/bottom_navigation_bar.dart';
import 'package:home_rental/features/profile/data/data_source/remote_datasource/profile_remote_datasource.dart';
import 'package:home_rental/features/profile/data/repository/profile_remote_repository/profile_remote_repository.dart';
import 'package:home_rental/features/profile/domain/use_case/fetch_user_usecase.dart';
import 'package:home_rental/features/profile/presentation/view/profile_view.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetBooking extends StatefulWidget {
  const GetBooking({super.key});

  @override
  _GetBookingState createState() => _GetBookingState();
}

class _GetBookingState extends State<GetBooking> {
  List bookings = [];
  String error = '';
  String? username;
  int _selectedIndex = 2;
  final BookingApiService _apiService = BookingApiService();
  Set<PropertyApiModel> favoriteProperties = {};
  List<PropertyApiModel> properties = [];

  @override
  void initState() {
    super.initState();
    username = 'misheel';
    if (username != null) {
      fetchBookings();
    }
  }

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GetBooking()),
      );
    } else if (index == 3) {
      final dio = Dio();
      final prefs = await SharedPreferences.getInstance();

      final profileRemoteDatasource = ProfileRemoteDatasource(dio, prefs);
      final profileRemoteRepository =
          ProfileRemoteRepository(profileRemoteDatasource, dio, prefs);
      final fetchUserUsecase = FetchUserUsecase(profileRemoteRepository);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProfilePage(fetchUserUsecase: fetchUserUsecase)));
    }
  }

  Future<void> fetchBookings() async {
    try {
      final fetchedBookings = await _apiService.fetchBookings(username!);
      setState(() {
        bookings = fetchedBookings;
      });
      print(bookings);
    } catch (e) {
      setState(() {
        error = 'No booking found';
      });
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    try {
      await _apiService.cancelBooking(bookingId);
      setState(() {
        bookings =
            bookings.where((booking) => booking['_id'] != bookingId).toList();
      });
    } catch (e) {
      setState(() {
        error = 'Error canceling booking: $e';
      });
    }
  }

  Future<void> checkoutBooking(String bookingId, BuildContext context) async {
    try {
      final bookingDetails = bookings.firstWhere(
        (booking) => booking['_id'] == bookingId,
        orElse: () => null,
      );

      if (bookingDetails == null) {
        setState(() {
          error = 'Booking not found';
        });
        return;
      }

      final totalPrice =
          double.tryParse(bookingDetails['totalPrice'].toString()) ?? 0.0;
      final checkInDate = bookingDetails['startDate'];
      final checkOutDate = bookingDetails['endDate'];

      print("Proceeding to confirm booking with totalPrice: $totalPrice");

      await _apiService.confirmBooking(bookingId);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckoutConfirmationPage(
                    totalPrice: totalPrice,
                    checkInDate: checkInDate,
                    checkOutDate: checkOutDate,
                  )));
    } catch (e) {
      setState(() {
        error = 'Error during checkout: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (error.isNotEmpty)
                Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
              if (bookings.isEmpty && error.isEmpty)
                const Center(child: Text('No bookings found.')),
              if (bookings.isNotEmpty)
                Expanded(
                  child: BookingList(
                    bookings: bookings,
                    cancelBooking: cancelBooking,
                    checkoutBooking: checkoutBooking,
                  ),
                ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ));
  }
}
