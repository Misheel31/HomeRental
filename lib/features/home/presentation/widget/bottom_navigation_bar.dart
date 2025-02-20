import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 28),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, size: 28),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark, size: 28),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 28),
          label: 'Profile',
        ),
      ],
      selectedItemColor: const Color.fromARGB(255, 101, 160, 190),
      unselectedItemColor: const Color.fromARGB(255, 181, 128, 128),
      backgroundColor: const Color.fromARGB(255, 29, 37, 50),
      elevation: 10,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
      ),
    );
  }
}
