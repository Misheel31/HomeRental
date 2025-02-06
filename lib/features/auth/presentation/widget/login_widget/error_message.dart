import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String? message;

  const ErrorMessage({this.message, super.key});

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        message!,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 14,
        ),
      ),
    );
  }
}
