import 'package:flutter/material.dart';
import 'package:favorite_places/models/place.dart';

class PlacesDetailsScreen extends StatelessWidget {
  final Place place;

  const PlacesDetailsScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          // You can add more details about the place here, such as location, description, etc.
        ],
      ),
    );
  }
}