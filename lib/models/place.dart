import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class Place {
  Place({required this.title, required this.image, this.location}) : id = uuid.v4();

  final String title;
  final File image;
  final String id;
  final PlaceLocation? location;
}


