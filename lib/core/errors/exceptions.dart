class APIException implements Exception {
  final String message;
  final String statusCode;

  const APIException({required this.message, required this.statusCode});
}

class CacheException implements Exception {
  final String message;
  final int statusCode;

  const CacheException({required this.message, required this.statusCode});
}

class GeneralException implements Exception {
  final String message;
  final int statusCode;

  const GeneralException({required this.message, required this.statusCode});
}
