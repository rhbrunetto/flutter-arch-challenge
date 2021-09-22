import 'package:crypto_challenge/modules/calculator/domain/models/price_model.dart';
import 'package:crypto_challenge/modules/calculator/view/blocs/calculator/calculator_cubit.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
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

  final currencyFormatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    locale: 'en_US',
    symbol: '',
  );

  @override
  void initState() {
    super.initState();
    calculatorCubit = Modular.get<CalculatorCubit>()..init(widget.priceModel);
    _usdController = TextEditingController();
    _coinController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
        ),
        body: BlocBuilder<CalculatorCubit, CalculatorState>(
          bloc: calculatorCubit,
          builder: (context, state) {
            if (state is! CalculatorLoaded) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            _coinController.text =
                currencyFormatter.format(state.valueInCoin.toString());
            _usdController.text =
                currencyFormatter.format(state.valueInUsd.toString());

            return Flex(
              direction: Axis.vertical,
              children: [
                // TODO: Remove
                const Text('In progress'),
                const SizedBox(height: 32.0),
                TextField(
                  key: _usdKey,
                  controller: _usdController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      calculatorCubit.onUsdValueChanged(value),
                ),
                const SizedBox(height: 32.0),
                TextField(
                  key: _coinKey,
                  controller: _coinController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      calculatorCubit.onCoinValueChanged(value),
                ),
              ],
            );
          },
        ),
      );
}
