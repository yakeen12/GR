import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  final Function(String) onImageSelected;

  ProfileImagePicker({required this.onImageSelected});

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
      widget.onImageSelected(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> pfp() {
      if (selectedImage != null) {
        return FileImage(selectedImage!);
      } else {
        return const NetworkImage(
            'https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg');
      }
    }

    return Center(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.black54),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(fit: BoxFit.cover, image: pfp()),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: pickImage,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 12, 13, 14),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
