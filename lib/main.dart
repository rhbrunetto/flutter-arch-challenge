import 'package:crypto_challenge/core/core_module.dart';
import 'package:crypto_challenge/env/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

export './env/env_production.dart';

Widget initApp(Environment environment) {
  WidgetsFlutterBinding.ensureInitialized();

  return ModularApp(
    module: CoreModule(environment),
    child: const AppWidget(),
  );
}
