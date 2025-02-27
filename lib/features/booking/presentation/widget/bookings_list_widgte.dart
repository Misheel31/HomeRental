import 'package:flutter/material.dart';

class BookingList extends StatelessWidget {
  final List bookings;
  final Function(String) cancelBooking;
  final Function(String, BuildContext) checkoutBooking;

  const BookingList({
    super.key,
    required this.bookings,
    required this.cancelBooking,
    required this.checkoutBooking,
  });

  @override
  Widget build(BuildContext context) {
    return bookings.isEmpty
        ? const Center(child: Text('No bookings found.'))
        : ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Property ID: ${booking['propertyId']}'),
                      Text(
                          'Start Date: ${DateTime.parse(booking['startDate']).toLocal()}'),
                      Text(
                          'End Date: ${DateTime.parse(booking['endDate']).toLocal()}'),
                      Text('Total Price: ${booking['totalPrice']}'),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => cancelBooking(booking['_id']),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text('Cancel Booking'),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                // Correctly pass both bookingId and context
                                checkoutBooking(booking['_id'], context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              child: const Text('Checkout'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
