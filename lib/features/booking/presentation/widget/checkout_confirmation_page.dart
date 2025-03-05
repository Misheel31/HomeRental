import 'package:flutter/material.dart';
import 'package:home_rental/features/home/presentation/view/home_view.dart';

class CheckoutConfirmationPage extends StatelessWidget {
  final double totalPrice;
  final String checkInDate;
  final String checkOutDate;

  const CheckoutConfirmationPage({
    super.key,
    required this.totalPrice,
    required this.checkInDate,
    required this.checkOutDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Confirmation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            const Text("Payment Successful!",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            const SizedBox(height: 16),
            Text("Total Amount Paid: \$${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Check-in Date: $checkInDate",
                style: const TextStyle(fontSize: 16)),
            Text("Check-out Date: $checkOutDate",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
