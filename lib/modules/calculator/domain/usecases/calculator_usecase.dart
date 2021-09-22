import 'package:crypto_challenge/modules/calculator/domain/models/price_model.dart';

class CalculatorUseCase {
  double convertToCoin(PriceModel priceModel, double valueInUsd) {
    final valueInCoin = valueInUsd / priceModel.priceInUsd;
    return valueInCoin;
  }

  double convertToUsd(PriceModel priceModel, double valueInCoin) {
    final valueInUsd = valueInCoin * priceModel.priceInUsd;
    return valueInUsd;
  }
}
