import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/data/db_util.dart';
import 'package:places/helpers/location.utils.dart';
import 'package:places/models/place.model.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _places = dataList
        .map((dataPlace) => Place(
              id: dataPlace['id'],
              title: dataPlace['title'],
              location: Location(
                  latitude: dataPlace['latitude'],
                  longitude: dataPlace['longitude'],
                  address: dataPlace['address']),
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

  Future<void> addPlace(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddressFrom(position);

    final place = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: Location(
          latitude: position.latitude,
          longitude: position.longitude,
          address: address),
      image: image,
    );
    _places.add(place);

    DbUtil.insert('places', {
      //inserindo no banco SQLite
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address
    });

    notifyListeners();
  }

  void removePlace(String id) async {
    await DbUtil.remove('places', id);
    _places = [...places].where((place) => place.id != id).toList();
    notifyListeners();
  }
}
