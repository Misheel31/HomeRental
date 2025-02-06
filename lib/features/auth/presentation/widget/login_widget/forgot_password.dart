import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final VoidCallback onTap;

  const ForgotPassword({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: const Text(
          "Forgot password?",
          style: TextStyle(fontSize: 14, color: Colors.blue),
        ),
      ),
    );
  }
}
