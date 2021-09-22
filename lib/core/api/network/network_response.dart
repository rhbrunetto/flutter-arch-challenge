abstract class NetworkResponse {}

class NetworkSuccessResponse implements NetworkResponse {
  NetworkSuccessResponse({
    required this.data,
    required this.status,
  });

  final dynamic data;
  final int status;
}

class NetworkFailResponse implements NetworkResponse {
  NetworkFailResponse({
    required this.message,
    required this.status,
    this.data,
  });

  final String message;
  final int status;
  final dynamic data;
}
