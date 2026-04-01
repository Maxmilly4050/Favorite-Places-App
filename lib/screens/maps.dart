import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

const PlaceLocation _defaultLocation = PlaceLocation(
  latitude: 37.422,
  longitude: -122.084,
  address: '1600 Amphitheatre Parkway, Mountain View, CA 94043, USA',
);

class MapsScreen extends StatefulWidget {
  const MapsScreen({
    super.key,
    this.location = _defaultLocation, 
    });


  final PlaceLocation location;

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Maps Screen'),
      ),
    );
  }
}