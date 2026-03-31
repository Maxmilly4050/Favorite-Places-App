import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, this.onPickImage});
  final void Function(File pickedImage)? onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );

      if (pickedImage == null) {
        return;
      }

      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      widget.onPickImage?.call(_selectedImage!);
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open the camera. Check app permissions.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takePicture,
        label: Text("Take Picture"),
        icon: Icon(Icons.camera)
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.contain,
          width: double.infinity,
        ),
      );
    }


    return Container(
      alignment: Alignment.center,
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: content,
    );
  }
}