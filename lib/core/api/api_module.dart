import './api_manager.dart';
import './managers/default_api_manager.dart';
import './network/network_provider.dart';
import './network/network_providers/dio/environment/default_dio_environment.dart';
import './network/network_providers/dio/environment/idio_environment.dart';
import './network/network_providers/dio/error/feathers_error_parser.dart';
import './network/network_providers/dio/error/idio_error_parser.dart';
import './network/network_providers/dio_provider.dart';
import './network/network_providers/mock_provider.dart';

import 'package:crypto_challenge/env/environment.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ApiModule extends Module {
  ApiModule({
    required this.environment,
  });

  final Environment environment;

  @override
  List<Bind> get binds => [
        Bind.singleton<IDioErrorParser>(
          (i) => FeathersDioErrorParser(),
        ),
        Bind.singleton<IDioEnvironment>(
          (i) => DefaultDioEnvironment(
            environment: environment,
          ),
        ),
        Bind.singleton<NetworkProvider>(
          (i) {
            if (environment.isMock) return const MockProvider();
            return DioProvider(
              dioEnvironment: i.get<IDioEnvironment>(),
              dioErrorParser: i.get<IDioErrorParser>(),
            );
          },
        ),
        Bind.singleton<IApiManager>(
          (i) => DefaultApiManager(provider: i.get<NetworkProvider>()),
        ),
      ];
}
