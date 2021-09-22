import 'package:crypto_challenge/common/definitions/types.dart';
import '../network/methods.dart';
import '../network/mock_strategy.dart';

class NetworkRequest {
  NetworkRequest({
    required this.endpoint,
    required this.method,
    this.body,
    this.headers,
    this.queryParameters,
    this.mockStrategy,
  });

  final String endpoint;
  final HttpMethod method;
  final Json? body;
  final Json? headers;
  final Json? queryParameters;
  final MockStrategy? mockStrategy;
}
