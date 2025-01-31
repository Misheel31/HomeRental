import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  Future<void> checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          context.read<RegisterBloc>().add(
                UploadImage(file: _image!),
              );
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // return BlocListener<RegisterBloc, RegisterState>(
    //   listener: (context, state) {
    //     if (state.isLoading) {
    //       // Show loading indicator
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(
    //           content: Text('Uploading image...'),
    //           duration: Duration(seconds: 2),
    //         ),
    //       );
    //     } else if (state.isSuccess) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(
    //           content: Text('Image uploaded successfully!'),
    //           backgroundColor: Colors.green,
    //           duration: Duration(seconds: 2),
    //         ),
    //       );
    //     } else {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(
    //           content: Text('Image upload failed!'),
    //           backgroundColor: Colors.red,
    //           duration: Duration(seconds: 2),
    //         ),
    //       );
    //     }
    //   },

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image Picker Section
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
                              textStyle: const TextStyle(color: Colors.white),
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
                              textStyle: const TextStyle(color: Colors.white),
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
              const SizedBox(height: 30),
              // Form title
              const Text(
                'Create Your Account',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 24),
              // Form Inputs Section
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email Input
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Username Input
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Password Input
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Confirm Password Input
                        TextFormField(
                          controller: _confirmpasswordController,
                          obscureText: !isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                      !isConfirmPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            } else if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        // Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final registerState =
                                    context.read<RegisterBloc>().state;
                                final imageName = registerState.imageName;
                                context.read<RegisterBloc>().add(
                                      RegisterUser(
                                        context: context,
                                        email: _emailController.text,
                                        username: _usernameController.text,
                                        password: _passwordController.text,
                                        confirmPassword:
                                            _confirmpasswordController.text,
                                        image: imageName,
                                      ),
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Sign In Redirect
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
