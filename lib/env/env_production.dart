import 'package:crypto_challenge/env/environment.dart';
import 'package:crypto_challenge/main.dart';
import 'package:flutter/widgets.dart';

class EnvironmentProduction extends Environment {
  @override
  EnvType get type => EnvType.production;

  @override
  String get baseUrl => 'https://api.coingecko.com/api/v3';

  @override
  int get connectTimeout => 5000;

  @override
  int get receiveTimeout => 60000;

  @override
  bool get disableRedScreenOfDeath => true;

  @override
  bool get hasCrashlytics => true;
}

/// Ponto de entrada desta configuração de ambiente
void main() async => runApp(initApp(EnvironmentProduction()));
