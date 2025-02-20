import 'package:flutter/material.dart';

Widget buildImageContainer(
  BuildContext context,
  Color color,
  String title,
  String subtitle,
  String imagePath, {
  bool isCircular = false,
  double? imageWidth,
  double? imageHeight,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  bool isTablet = screenWidth > 600;

  return SafeArea(
    child: Container(
      color: color,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 40 : 20,
        vertical: isTablet ? 50 : 30,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: imageWidth ??
                  (isTablet ? screenWidth * 0.6 : screenWidth * 0.8),
              height: imageHeight ??
                  (isTablet ? screenHeight * 0.45 : screenHeight * 0.39),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'GreatVibes Regular',
                fontWeight: FontWeight.w500,
                fontSize: isTablet ? 50 : 45,
                color: const Color(0xFF5D4037),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SansSerif',
                  fontSize: isTablet ? 20 : 18,
                  color: const Color.fromARGB(255, 93, 71, 65),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
