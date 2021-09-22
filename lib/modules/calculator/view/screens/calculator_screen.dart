import 'package:crypto_challenge/modules/calculator/domain/models/price_model.dart';
import 'package:crypto_challenge/modules/calculator/view/blocs/calculator/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({
    Key? key,
    required this.priceModel,
  }) : super(key: key);

  final PriceModel priceModel;

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late final CalculatorCubit calculatorCubit;

  late final TextEditingController _usdController;
  late final TextEditingController _coinController;

  final _usdKey = GlobalKey();
  final _coinKey = GlobalKey();

  final currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '');

  @override
  void initState() {
    super.initState();
    calculatorCubit = Modular.get<CalculatorCubit>()..init(widget.priceModel);
    _usdController = TextEditingController();
    _coinController = TextEditingController();
  }

  void _updateCoin(double newValue) =>
      _coinController.text = currencyFormatter.format(newValue);

  void _updateUsd(double newValue) =>
      _usdController.text = currencyFormatter.format(newValue);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<CalculatorCubit, CalculatorState>(
            bloc: calculatorCubit,
            builder: (context, state) {
              if (state is! CalculatorLoaded) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is CalculatorUpdated) {
                if (state.isCoinChanged) {
                  _updateCoin(state.valueInCoin);
                } else {
                  _updateUsd(state.valueInUsd);
                }
              } else {
                _updateCoin(state.valueInCoin);
                _updateUsd(state.valueInUsd);
              }

              return Flex(
                direction: Axis.vertical,
                children: [
                  const SizedBox(height: 32.0),
                  TextField(
                    key: _coinKey,
                    controller: _coinController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefix: Text('${state.coin.symbol.toUpperCase()} '),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 32.0),
                    onChanged: (value) =>
                        calculatorCubit.onCoinValueChanged(value),
                  ),
                  const SizedBox(height: 32.0),
                  const Text('equals to'),
                  const SizedBox(height: 32.0),
                  TextField(
                    key: _usdKey,
                    controller: _usdController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefix: Text('USD '),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 32.0),
                    onChanged: (value) =>
                        calculatorCubit.onUsdValueChanged(value),
                  ),
                ],
              );
            },
          ),
        ),
      );
}
