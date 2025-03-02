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

  void _showCancelConfirmation(BuildContext context, String bookingId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Cancel Booking"),
            content:
                const Text("Are you sure you want to cancel this booking?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    cancelBooking(bookingId);
                  },
                  child: const Text("Yes")),
            ],
          );
        });
  }

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
                              onPressed: () => _showCancelConfirmation(
                                  context, booking['_id']),
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
