import './network/network_response.dart';

class ApiError {
  ApiError({
    required this.message,
    this.isUnauthorized = false,
  });

  final String message;
  final bool isUnauthorized;

  factory ApiError.fromNetworkResponse(NetworkFailResponse failResponse) =>
      ApiError(
        message: failResponse.message,
        isUnauthorized: failResponse.status == 401,
      );
}
