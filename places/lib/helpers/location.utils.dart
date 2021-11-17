const GOOGLE_API_KEY = "AIzaSyAFyts5uUlQmBUpSSYJ48z8IhRUG31kyHI";

class LocationUtil {
  static String generetaLocationPreview(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%$latitude,$longitude&key=$GOOGLE_API_KEY';
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
