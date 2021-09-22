import './api_response.dart';
import './network/network_provider.dart';
import './network/network_request.dart';

abstract class IApiManager {
  final NetworkProvider provider;

  IApiManager(this.provider);

  Future<ApiResponse<T>> apiRequest<T>(
    NetworkRequest request, {
    T Function(dynamic)? buildData,
  });
}
