import 'package:flutter/material.dart';

class GuestSelector extends StatelessWidget {
  final int guestCount;
  final Function(int) onIncrease;
  final Function(int) onDecrease;

  const GuestSelector({
    super.key,
    required this.guestCount,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => onDecrease(guestCount),
          icon: const Icon(Icons.remove),
        ),
        Text('$guestCount'),
        IconButton(
          onPressed: () => onIncrease(guestCount),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
