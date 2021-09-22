import 'package:bloc/bloc.dart';
import 'package:crypto_challenge/env/environment.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

part 'starter_state.dart';

class StarterCubit extends Cubit<StarterState> {
  StarterCubit({
    required this.environment,
  }) : super(AppNotStartedState());

  final Environment environment;

  void init() async {
    emit(AppLoadingState());

    await _loadAppDependencies();
    await Future.delayed(const Duration(seconds: 1));

    emit(AppStartedState());
  }

  Future<void> _loadAppDependencies() async {
    debugPrint('================================================');
    debugPrint(environment.type.toString());
    debugPrint('================================================');

    Intl.defaultLocale = 'pt_BR';

    if (environment.disableRedScreenOfDeath) {
      ErrorWidget.builder = (FlutterErrorDetails details) => Container();
    }

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: SystemUiOverlay.values,
    );
  }
}
