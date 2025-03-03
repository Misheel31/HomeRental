import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
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
            : const AssetImage('assets/images/image1.png') as ImageProvider,
        child: const Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.teal,
            child: Icon(Icons.edit, size: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
