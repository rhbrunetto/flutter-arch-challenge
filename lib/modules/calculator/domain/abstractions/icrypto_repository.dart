import 'package:crypto_challenge/modules/calculator/domain/models/coin_model.dart';
import 'package:crypto_challenge/modules/calculator/domain/models/price_model.dart';
import 'package:dartz/dartz.dart';

abstract class ICryptoRepository {
  Future<Either<String, List<PriceModel>>> findPrices({
    required List<CoinModel> coins,
  });

  Future<Either<String, List<CoinModel>>> findCoins();
}
