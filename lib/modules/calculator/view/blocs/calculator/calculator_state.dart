part of 'calculator_cubit.dart';

abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

class CalculatorLoaded extends CalculatorState {
  CalculatorLoaded({
    required this.coin,
    required this.valueInCoin,
    required this.valueInUsd,
  });

  final CoinModel coin;
  final double valueInUsd;
  final double valueInCoin;
}

class CalculatorUpdated extends CalculatorLoaded {
  CalculatorUpdated({
    required CoinModel coin,
    required double valueInUsd,
    required double valueInCoin,
    this.isCoinChanged = false,
  }) : super(
          coin: coin,
          valueInUsd: valueInUsd,
          valueInCoin: valueInCoin,
        );

  final bool isCoinChanged;
}
