import 'package:flutter/material.dart';

class TotalPriceDisplay extends StatelessWidget {
  final double totalPrice;

  const TotalPriceDisplay({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return totalPrice > 0
        ? Text(
            'Total Price: \$${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16),
          )
        : const SizedBox.shrink();
  }
}
