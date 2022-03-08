class BluethoothException implements Exception {
  final String message;
  // final int statusCode;

  BluethoothException({required this.message});

  @override
  String toString() {
    return message;
  }
}
