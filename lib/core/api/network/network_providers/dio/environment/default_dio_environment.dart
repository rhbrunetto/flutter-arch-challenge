import 'package:dio/dio.dart';

import 'package:crypto_challenge/env/environment.dart';

import '../../../../network/network_providers/dio/environment/idio_environment.dart';

class DefaultDioEnvironment implements IDioEnvironment {
  DefaultDioEnvironment({
    required this.environment,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: environment.baseUrl,
            connectTimeout: environment.connectTimeout,
            receiveTimeout: environment.receiveTimeout,
          ),
        )..interceptors.addAll(
            [
              LogInterceptor(),
            ],
          );

  final Environment environment;

  @override
  final Dio dio;
}
