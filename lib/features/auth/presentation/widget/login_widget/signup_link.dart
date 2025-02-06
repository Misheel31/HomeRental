import 'package:flutter/material.dart';

class SignupLink extends StatelessWidget {
  final VoidCallback onTap;

  const SignupLink({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            "Signup",
            style: TextStyle(
                color: Color(0xFF0ACF83), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
