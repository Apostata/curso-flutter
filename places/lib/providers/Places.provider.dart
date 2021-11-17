import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:places/data/db_util.dart';
import 'package:places/models/place.model.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  Future<void> loadPlaces() async {
    final dataList = await DdUtil.getData('places');
    _places = dataList
        .map((dataPlace) => Place(
              id: dataPlace['id'],
              title: dataPlace['title'],
              location: null,
              image: File(dataPlace['image']),
            ))
        .toList();
    notifyListeners();
  }

  List<Place> get places {
    return [..._places];
  }

  int get placesCount {
    return _places.length;
  }

  Place getPlace(String id) {
    return _places.where((place) => place.id == id).single;
  }

  Future<void> getCurrentLocation() async {}

  void addPlace(String title, File image) {
    final place = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: null,
      image: image,
    );
    _places.add(place);

    DdUtil.insert('places', {
      //inserindo no banco SQLite
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
    });

    notifyListeners();
  }

  void removePlace(String id) async {
    await DdUtil.remove('places', id);
    _places = [...places].where((place) => place.id != id).toList();
    notifyListeners();
  }
}
