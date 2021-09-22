import 'package:crypto_challenge/modules/calculator/domain/models/coin_model.dart';

class PriceModel {
  final CoinModel coinModel;
  final double priceInUsd;

  PriceModel({
    required this.coinModel,
    required this.priceInUsd,
  });
}
