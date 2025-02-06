import 'package:flutter/material.dart';

class PasswordFieldWidegt extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPasswordVisible;
  final VoidCallback onToggleVisibility;
  final String? Function(String?)? validator;

  const PasswordFieldWidegt({
    super.key,
    required this.controller,
    required this.labelText,
    required this.isPasswordVisible,
    required this.onToggleVisibility,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: onToggleVisibility,
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      validator: validator,
    );
  }
}
