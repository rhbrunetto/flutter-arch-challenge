import '../network/network_request.dart';
import '../network/network_response.dart';

abstract class NetworkProvider {
  Future<NetworkResponse> get(NetworkRequest request);
  Future<NetworkResponse> post(NetworkRequest request);
  Future<NetworkResponse> put(NetworkRequest request);
  Future<NetworkResponse> delete(NetworkRequest request);
  Future<NetworkResponse> patch(NetworkRequest request);
}
