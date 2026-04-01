import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const PlaceLocation _defaultLocation = PlaceLocation(
  latitude: 37.422,
  longitude: -122.084,
  address: '1600 Amphitheatre Parkway, Mountain View, CA 94043, USA',
);

class MapsScreen extends StatefulWidget {
  const MapsScreen({
    super.key,
    this.location = _defaultLocation, 
    this.isSelecting = true,
    });


  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Select Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation ?? LatLng(widget.location.latitude, widget.location.longitude));
              },
            ),
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting ? null : (position){
          setState(() {
            _pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        markers: _pickedLocation == null && widget.isSelecting
            ? {}
            : {
          Marker(
            markerId: const MarkerId('m1'),
            position: _pickedLocation ?? LatLng(widget.location.latitude, widget.location.longitude),
          ),
        },
      ),
    );
  }
}