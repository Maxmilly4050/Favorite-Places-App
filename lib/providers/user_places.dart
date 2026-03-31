import 'package:favorite_places/models/place.dart';
import 'package:riverpod/riverpod.dart';

class UserPlacesNotifier extends Notifier<List<Place>> {
  @override
  List<Place> build() {
    return [];
  }

  void addPlace(Place place) {
    state = [place, ...state];
  }

}

final userPlacesProvider = NotifierProvider<UserPlacesNotifier, List<Place>>(() {
  return UserPlacesNotifier();
});