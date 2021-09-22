import 'package:crypto_challenge/core/view/blocs/starter/starter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
    required this.routeWhenStarted,
  }) : super(key: key);

  final String routeWhenStarted;

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<StarterCubit, StarterState>(
        bloc: Modular.get<StarterCubit>()..init(),
        listenWhen: (_, current) => current is AppStartedState,
        listener: (context, state) => Modular.to.pushReplacementNamed(
          routeWhenStarted,
        ),
        builder: (context, state) => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
}
