import 'package:dio/dio.dart';

import '../../network/network_providers/dio/environment/idio_environment.dart';
import '../../network/network_providers/dio/error/idio_error_parser.dart';
import '../../network/network_request.dart';
import '../../network/network_response.dart';
import '../../network/network_provider.dart';

class DioProvider implements NetworkProvider {
  DioProvider({
    required this.dioEnvironment,
    required this.dioErrorParser,
  });

  final IDioEnvironment dioEnvironment;
  final IDioErrorParser dioErrorParser;

  Future<NetworkResponse> _safeRequest(NetworkRequest request) async {
    try {
      final response = await dioEnvironment.dio.request(
        request.endpoint,
        data: request.body,
        queryParameters: request.queryParameters,
        options: Options(
          method: request.method.identifier,
          headers: request.headers,
        ),
      );
      return NetworkSuccessResponse(
        data: response.data,
        status: response.statusCode!,
      );
    } on DioError catch (error) {
      return dioErrorParser.build(error);
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
