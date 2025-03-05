import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getApplication() {
    return ThemeData(
      // primarySwatch: Colors.blueGrey,
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat Bold',
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat Bold',
        ),
        // backgroundColor: Colors.blueGrey,
        backgroundColor: Colors.red,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )),
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
            fontSize: 20,
          ),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey))),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
