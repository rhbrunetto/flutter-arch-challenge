import '../../network/network_request.dart';
import '../../network/network_response.dart';
import '../../network/network_provider.dart';

class MockProvider implements NetworkProvider {
  const MockProvider();

  Future<NetworkResponse> _safeRequest(NetworkRequest request) async {
    try {
      final response = await request.mockStrategy?.data;
      if (response == null) {
        throw _MockException(
          statusCode: 404,
          message: '[MOCK] NOT FOUND',
        );
      }
      return NetworkSuccessResponse(
        status: 200,
        data: response,
      );
    } on _MockException catch (error) {
      return NetworkFailResponse(
        status: error.statusCode,
        message: error.message,
      );
    } catch (error) {
      return NetworkFailResponse(
        status: 502,
        message: error.toString(),
      );
    }
  }

  @override
  Future<NetworkResponse> get(NetworkRequest request) => _safeRequest(request);

  @override
  Future<NetworkResponse> post(NetworkRequest request) => _safeRequest(request);

  @override
  Future<NetworkResponse> put(NetworkRequest request) => _safeRequest(request);

  @override
  Future<NetworkResponse> delete(NetworkRequest request) =>
      _safeRequest(request);

  @override
  Future<NetworkResponse> patch(NetworkRequest request) =>
      _safeRequest(request);
}

class _MockException implements Exception {
  _MockException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;
}
