import 'package:flutter/material.dart';
import 'package:places/models/place.model.dart';

class Places with ChangeNotifier {
  final List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  int get placesCount {
    return _places.length;
  }

  Place getPlace(String id) {
    return _places.where((place) => place.id == id).single;
  }
}
