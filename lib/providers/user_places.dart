import 'package:favorite_places/models/place.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:riverpod/riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'dart:io';

class UserPlacesNotifier extends Notifier<List<Place>> {
  @override
  List<Place> build() {
    return [];
  }

  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)',
      );
    },
    version: 1,
    );
    return db;
  }

  Future<void> loadPlaces() async {
    final db = await _getDatabase();

    final data = await db.query('user_places');
    final places = data.map((item) => Place(
      title: item['title'] as String,
      image: File(item['image'] as String),
      location: PlaceLocation(
        latitude: item['loc_lat'] as double,
        longitude: item['loc_lng'] as double,
        address: item['address'] as String,
      ),
      id: item['id'] as String,
    )).toList();

    state = places;
  }

  void addPlace(Place place) async{
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(place.image.path);
    final savedImage = await place.image.copy('${appDir.path}/$fileName');
    final newPlace = Place(
      title: place.title,
      image: savedImage,
      location: place.location,
      id: place.id,
    );

    final db = await _getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location?.latitude,
      'loc_lng': newPlace.location?.longitude,
      'address': newPlace.location?.address,
    });

    state = [newPlace, ...state];
  }

}

final userPlacesProvider = NotifierProvider<UserPlacesNotifier, List<Place>>(() {
  return UserPlacesNotifier();
});