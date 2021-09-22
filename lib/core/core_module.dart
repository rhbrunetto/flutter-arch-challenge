import 'package:crypto_challenge/core/api/api_module.dart';
import 'package:crypto_challenge/core/view/blocs/starter/starter_cubit.dart';
import 'package:crypto_challenge/core/view/screens/splash_screen.dart';
import 'package:crypto_challenge/env/environment.dart';
import 'package:crypto_challenge/modules/calculator/calculator_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  CoreModule(this.env);

  final Environment env;

  @override
  List<Bind> get binds => [
        ...ApiModule(environment: env).binds,
        Bind.instance<Environment>(env),
        Bind.singleton(
          (i) => StarterCubit(
            environment: i.get<Environment>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/calculator', module: CalculatorModule()),
        ChildRoute(
          '/splash',
          child: (_, args) => const SplashScreen(
            routeWhenStarted: '/calculator/',
          ),
        ),
      ];
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        initialRoute: '/splash',
        debugShowCheckedModeBanner: !Modular.get<Environment>().isProduction,
      ).modular();
}
