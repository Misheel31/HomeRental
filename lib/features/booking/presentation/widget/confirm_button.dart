import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback onPressed;

  const ConfirmButton({
    super.key,
    required this.isLoading,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading || !isEnabled ? null : onPressed,
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('Confirm Booking'),
    );
  }
}
