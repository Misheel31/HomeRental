import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const InputFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          )),
      validator: validator,
    );
  }
}
