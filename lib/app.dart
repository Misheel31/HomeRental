import 'package:flutter/material.dart';
import 'package:home_rental/screen/login.dart';
import 'package:home_rental/screen/on_boarding_screen.dart';
import 'package:home_rental/screen/register.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OnboardingScreen(),
    );
  }
}
