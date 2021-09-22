import 'package:bloc/bloc.dart';
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
        coinName: priceModel.coinModel.name,
        valueInCoin: 1.0,
        valueInUsd: priceModel.priceInUsd,
      ),
    );
  }

  void onCoinValueChanged(String coinStringValue) {
    final newCoinValue = double.tryParse(coinStringValue);
    if (newCoinValue == null) return;
    if (_priceModel == null) return;
    final newUsdValue = calculatorUseCase.convertToUsd(
      _priceModel!,
      newCoinValue,
    );
    emit(
      CalculatorLoaded(
        coinName: _priceModel!.coinModel.name,
        valueInCoin: newCoinValue,
        valueInUsd: newUsdValue,
      ),
    );
  }

  void onUsdValueChanged(String usdStringValue) {
    final newUsdValue = double.tryParse(usdStringValue);
    if (newUsdValue == null) return;
    if (_priceModel == null) return;
    final newCoinValue = calculatorUseCase.convertToUsd(
      _priceModel!,
      newUsdValue,
    );
    emit(
      CalculatorLoaded(
        coinName: _priceModel!.coinModel.name,
        valueInCoin: newCoinValue,
        valueInUsd: newUsdValue,
      ),
    );
  }
}
