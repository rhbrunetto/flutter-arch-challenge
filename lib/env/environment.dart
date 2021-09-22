enum EnvType { mock, development, production }

abstract class Environment {
  /// Tipo de ambiente utilizado
  EnvType get type;

  /// URL base da API
  String get baseUrl;

  // Timeout de conexão com a API
  int get connectTimeout;

  // Timeout de recebimento de dados da API
  int get receiveTimeout;

  // Timeout de recebimento de dados da API
  bool get disableRedScreenOfDeath;

  // Submete dados ao crashlytics
  bool get hasCrashlytics => false;
}

extension EnvironmentIdentifiers on Environment {
  bool get isDevelopment => type == EnvType.development;

  bool get isMock => type == EnvType.mock;

  bool get isProduction => type == EnvType.production;
}
