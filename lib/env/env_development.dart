import 'package:crypto_challenge/env/environment.dart';
import 'package:crypto_challenge/main.dart';
import 'package:flutter/widgets.dart';

class EnvironmentDevelopment extends Environment {
  @override
  EnvType get type => EnvType.development;

  @override
  String get baseUrl => 'https://api.coingecko.com/api/v3';

  @override
  int get connectTimeout => 5000;

  @override
  int get receiveTimeout => 60000;

  @override
  bool get disableRedScreenOfDeath => false;
}

/// Ponto de entrada desta configuração de ambiente
void main() async => runApp(initApp(EnvironmentDevelopment()));
