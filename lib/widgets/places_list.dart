import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/places_details.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const Center(
        child: Text('No places added yet.'),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) {
        final place = places[index];
        return ListTile(
          leading: CircleAvatar(
              backgroundImage: FileImage(places[index].image),
            ),
          // leading: CircleAvatar(
          //   backgroundImage: FileImage(place),
          // ),
          title: Text(place.title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface)),
          // subtitle: Text(place.location.address),
          subtitle: Text(place.location!.address, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => PlacesDetailsScreen(place: places[index]),
            ));
          },
        );
      },
    );

  }
}