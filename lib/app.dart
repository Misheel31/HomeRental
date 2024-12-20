import 'package:flutter/material.dart';
import 'package:home_rental/core/app_theme/app_theme.dart';
import 'package:home_rental/screen/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Login(),
      debugShowCheckedModeBanner: false,
      theme: getApplication(),
    );
  }
}
