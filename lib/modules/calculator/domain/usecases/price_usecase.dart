import 'package:crypto_challenge/modules/calculator/domain/abstractions/icrypto_repository.dart';
import 'package:crypto_challenge/modules/calculator/domain/models/coin_model.dart';
import 'package:crypto_challenge/modules/calculator/domain/models/price_model.dart';
import 'package:dartz/dartz.dart';

class PriceUseCase {
  PriceUseCase({
    required this.cryptoRepository,
  });

  final ICryptoRepository cryptoRepository;

  Future<Either<String, List<PriceModel>>> find(List<CoinModel> coins) =>
      cryptoRepository.findPrices(coins: coins);
}
