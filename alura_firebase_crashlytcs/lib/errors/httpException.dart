class HttpException implements Exception {
  final String message;
  final int? statusCode;
  // final int statusCode;

  HttpException({required this.message, this.statusCode});

  @override
  String toString() {
    return message;
  }
}
