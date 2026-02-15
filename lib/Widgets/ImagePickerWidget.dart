import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/colors.dart'; // Your AppColors file

class ImagePickerWidget extends StatefulWidget {
  final String title;
  final double width;
  final double height;
  final Function(File?) onImagePicked;

  const ImagePickerWidget({
    super.key,
    required this.title,
    required this.onImagePicked,
    this.width = 180,
    this.height = 70,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
      widget.onImagePicked(_pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: _pickedImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                _pickedImage!,
                fit: BoxFit.cover,
              ),
            )
                : Icon(Icons.upload_file, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
