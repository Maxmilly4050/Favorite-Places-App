import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title for the place.')),
      );
      return;
    }
      ref.read(userPlacesProvider.notifier).addPlace(
        Place(title: enteredTitle, image: _selectedImage!), // Use the selected image or a placeholder
      );

      Navigator.of(context).pop();
    // Save the place using the entered title
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 18),
            ),
            const SizedBox(height: 10),
            ImageInput(
              onPickImage: (File pickedImage) {
                setState(() {
                  _selectedImage = pickedImage;
                });
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(onPressed: _savePlace, label: const Text('Add Place'), icon: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}