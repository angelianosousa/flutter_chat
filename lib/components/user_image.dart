import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  final void Function(File) onImagePick;

  const UserImage({required this.onImagePick, super.key});

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      setState(() => _image = File(pickedImage.path));
    }

    widget.onImagePick(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        TextButton(
          onPressed: _pickImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image, color: Theme.of(context).primaryColor),
              SizedBox(width: 10),
              Text('Selecione uma imagem'),
            ],
          ),
        ),
      ],
    );
  }
}
