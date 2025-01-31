import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/features/auth/presentation/view/login_view.dart';
import 'package:home_rental/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileViewState();
}

Future<void> checkCameraPermission() async {
  if (await Permission.camera.request().isRestricted ||
      await Permission.camera.request().isDenied) {
    await Permission.camera.request();
  }
}

class _ProfileViewState extends State<ProfileScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // Dispatch UploadImage event to RegisterBloc
        context.read<RegisterBloc>().add(UploadImage(file: _image!));
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isLoading) {
          // Show loading indicator
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Uploading image...'),
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Image uploaded successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Image upload failed!'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              checkCameraPermission();
                              _pickImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              _pickImage(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.image),
                            label: const Text('Gallery'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const AssetImage('assets/images/image1.png')
                          as ImageProvider,
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Admin',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'admin@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),

              // Profile Options
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blueAccent),
                title: const Text('Edit Profile'),
                onTap: () {
                  // Navigate to Edit Profile Screen
                },
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.settings, color: Colors.blueAccent),
                title: const Text('Settings'),
                onTap: () {
                  // Navigate to Settings Screen
                },
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.history, color: Colors.blueAccent),
                title: const Text('Rental History'),
                onTap: () {
                  // Navigate to Rental History Screen
                },
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.help, color: Colors.blueAccent),
                title: const Text('Help & Support'),
                onTap: () {
                  // Navigate to Help & Support Screen
                },
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
