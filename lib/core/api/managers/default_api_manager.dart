import 'package:crypto_challenge/common/exceptions/message_exception.dart';
import '../api_error.dart';
import '../api_manager.dart';
import '../api_response.dart';
import '../network/network_provider.dart';
import '../network/network_request.dart';
import '../network/network_response.dart';

class DefaultApiManager implements IApiManager {
  DefaultApiManager({
    required this.provider,
  });

  @override
  final NetworkProvider provider;

  @override
  Future<ApiResponse<T>> apiRequest<T>(
    NetworkRequest request, {
    T Function(dynamic)? buildData,
  }) async {
    try {
      final response = await request.method.request(
        provider: provider,
        request: request,
      );

      if (response is NetworkFailResponse) {
        return ApiResponseFail<T>(
          error: ApiError.fromNetworkResponse(response),
        );
      }

      if (response is NetworkSuccessResponse) {
        return ApiResponseSuccess<T>(
          data: buildData?.call(response.data) ?? response.data,
        );
      }
      throw MessageException('Ocorreu um erro interno');
    } catch (err) {
      return ApiResponseFail<T>(
        error: ApiError(
          message: err.toString(),
        ),
      );
    }
  }
}
