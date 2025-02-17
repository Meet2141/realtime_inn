class SerializerFunctionException implements Exception {
  const SerializerFunctionException();
}

class ConnectionException implements Exception {
  const ConnectionException();
}

class CheckConnectionException implements ConnectionException {
  const CheckConnectionException();
}

class ConnectionTimeoutException implements ConnectionException {
  const ConnectionTimeoutException();
}

class HttpServiceException implements Exception {
  const HttpServiceException({
    required this.statusCode,
    this.message,
    this.errors,
  });

  final int statusCode;
  final String? message;
  final Map<String, dynamic>? errors;
}
