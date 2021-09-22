import 'package:crypto_challenge/modules/calculator/domain/abstractions/icrypto_repository.dart';
import 'package:crypto_challenge/modules/calculator/domain/models/coin_model.dart';
import 'package:dartz/dartz.dart';

class CoinUseCase {
  CoinUseCase({
    required this.cryptoRepository,
  });

  final ICryptoRepository cryptoRepository;

  Future<Either<String, List<CoinModel>>> find() =>
      cryptoRepository.findCoins();
}
