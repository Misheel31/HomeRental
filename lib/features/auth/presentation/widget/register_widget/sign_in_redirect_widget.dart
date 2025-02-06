import 'package:flutter/material.dart';

class SignInRedirectWidget extends StatelessWidget {
  final VoidCallback onTap;

  const SignInRedirectWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?'),
        TextButton(
          onPressed: onTap,
          child: const Text(
            'Sign In',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
