import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isTablet;
  final String title;
  final List<Widget> actions;

  const CustomAppBar({
    super.key,
    required this.isTablet,
    required this.title,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        (title),
        style: TextStyle(
          fontSize: isTablet ? 24 : 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(0.5),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
