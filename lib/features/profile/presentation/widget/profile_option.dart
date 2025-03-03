import 'package:flutter/material.dart';
import 'package:home_rental/features/auth/presentation/view/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Logout"),
            content: const Text("Are you sure you want to logout?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("No")),
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('isLoggedIn');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()));
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.edit, color: Colors.blueAccent),
          title: const Text('Edit Profile'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.blueAccent),
          title: const Text('Settings'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.android, color: Colors.blueAccent),
          title: const Text('Version 1.0.0'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Logout'),
            onTap: () => _showLogoutConfirmation(context)),
      ],
    );
  }
}
