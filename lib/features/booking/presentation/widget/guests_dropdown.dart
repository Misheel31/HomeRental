import 'package:flutter/material.dart';

class GuestsDropdown extends StatelessWidget {
  final int guests;
  final ValueChanged<int?> onChanged;

  const GuestsDropdown({
    super.key,
    required this.guests,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Guests:'),
        const SizedBox(width: 8),
        DropdownButton<int>(
          value: guests,
          items: List.generate(
            10,
            (index) => DropdownMenuItem(
              value: index + 1,
              child: Text('${index + 1}'),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
