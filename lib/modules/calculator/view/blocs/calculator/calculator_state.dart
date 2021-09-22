part of 'calculator_cubit.dart';

abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

class CalculatorLoaded extends CalculatorState {
  CalculatorLoaded({
    required this.coinName,
    required this.valueInCoin,
    required this.valueInUsd,
  });

  final String coinName;
  final double valueInUsd;
  final double valueInCoin;
}
