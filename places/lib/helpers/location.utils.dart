import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = "AIzaSyAFyts5uUlQmBUpSSYJ48z8IhRUG31kyHI";

class LocationUtil {
  static String generetaLocationPreview(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%$latitude,$longitude&key=$GOOGLE_API_KEY';
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAddressFrom(LatLng location) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location.latitude},${location.longitude}&key=$GOOGLE_API_KEY';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
