import 'package:bloc/bloc.dart';
import 'package:crypto_challenge/modules/calculator/domain/models/coin_model.dart';
import 'package:crypto_challenge/modules/calculator/domain/models/price_model.dart';
import 'package:crypto_challenge/modules/calculator/domain/usecases/calculator_usecase.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit({
    required this.calculatorUseCase,
  }) : super(CalculatorInitial());

  final CalculatorUseCase calculatorUseCase;

  PriceModel? _priceModel;

  void init(PriceModel priceModel) {
    _priceModel = priceModel;
    emit(
      CalculatorLoaded(
        coin: priceModel.coinModel,
        valueInCoin: 1.0,
        valueInUsd: priceModel.priceInUsd,
      ),
    );
  }

  void onCoinValueChanged(String coinStringValue) {
    final newCoinValue = double.tryParse(coinStringValue.replaceAll(',', ''));
    if (newCoinValue == null) return;
    if (_priceModel == null) return;
    final newUsdValue = calculatorUseCase.convertToUsd(
      _priceModel!,
      newCoinValue,
    );
    emit(
      CalculatorUpdated(
        coin: _priceModel!.coinModel,
        valueInCoin: newCoinValue,
        valueInUsd: newUsdValue,
        isCoinChanged: false,
      ),
    );
  }

  void onUsdValueChanged(String usdStringValue) {
    final newUsdValue = double.tryParse(usdStringValue.replaceAll(',', ''));
    if (newUsdValue == null) return;
    if (_priceModel == null) return;
    final newCoinValue = calculatorUseCase.convertToCoin(
      _priceModel!,
      newUsdValue,
    );
    emit(
      CalculatorUpdated(
        coin: _priceModel!.coinModel,
        valueInCoin: newCoinValue,
        valueInUsd: newUsdValue,
        isCoinChanged: true,
      ),
    );
  }
}
