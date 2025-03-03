import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String? username;

  const ProfileHeader({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          username ?? 'Guest',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
