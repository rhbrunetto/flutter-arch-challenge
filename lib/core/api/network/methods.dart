import '../network/network_response.dart';
import '../network/network_provider.dart';
import '../network/network_request.dart';

abstract class HttpMethod {
  String get identifier;

  Future<NetworkResponse> request({
    required NetworkProvider provider,
    required NetworkRequest request,
  });
}

class Get implements HttpMethod {
  const Get();

  @override
  String get identifier => 'GET';

  @override
  Future<NetworkResponse> request({
    required NetworkProvider provider,
    required NetworkRequest request,
  }) =>
      provider.get(request);
}

class Patch implements HttpMethod {
  const Patch();

  @override
  String get identifier => 'PATCH';

  @override
  Future<NetworkResponse> request({
    required NetworkProvider provider,
    required NetworkRequest request,
  }) =>
      provider.patch(request);
}

class Put implements HttpMethod {
  const Put();

  @override
  String get identifier => 'PUT';

  @override
  Future<NetworkResponse> request({
    required NetworkProvider provider,
    required NetworkRequest request,
  }) =>
      provider.put(request);
}

class Post implements HttpMethod {
  const Post();

  @override
  String get identifier => 'POST';

  @override
  Future<NetworkResponse> request({
    required NetworkProvider provider,
    required NetworkRequest request,
  }) =>
      provider.post(request);
}

class Delete implements HttpMethod {
  const Delete();

  @override
  String get identifier => 'DELETE';

  @override
  Future<NetworkResponse> request({
    required NetworkProvider provider,
    required NetworkRequest request,
  }) =>
      provider.delete(request);
}
