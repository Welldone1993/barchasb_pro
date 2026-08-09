class Failure {
  final String message;
  Failure(this.message);
}

class ServerException implements Exception {
  final String? message;
  ServerException({this.message});
}