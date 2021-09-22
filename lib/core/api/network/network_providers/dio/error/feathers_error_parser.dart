import 'package:dio/dio.dart';
import '../../../../network/network_providers/dio/error/idio_error_parser.dart';
import '../../../../network/network_response.dart';

class FeathersDioErrorParser implements IDioErrorParser {
  String _buildMessage(DioError error) {
    const _defaultMessage = 'An error occurred';

    if (error.type == DioErrorType.other ||
        error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.receiveTimeout ||
        error.type == DioErrorType.sendTimeout) {
      return 'Connection error. Check your internet connection and try again.';
    }

    if (error.type == DioErrorType.response && error.response != null) {
      final response = error.response!;
      final statusCode = response.statusCode ?? 502;

      if (statusCode >= 500) {
        return 'An error occurred, please try again later.';
      }

      final _responseError = response.data['error'] != null
          ? response.data['error']['message'] as String
          : null;

      return _responseError ?? _defaultMessage;
    }

    return _defaultMessage;
  }

  @override
  NetworkResponse build(DioError error) => NetworkFailResponse(
        data: error.response?.data,
        message: _buildMessage(error),
        status: error.response?.statusCode ?? 502,
      );
}
