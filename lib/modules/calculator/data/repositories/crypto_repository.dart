import 'package:crypto_challenge/core/api/api_response.dart';
import 'package:crypto_challenge/modules/calculator/data/datasources/crypto_local_datasource.dart';
import 'package:crypto_challenge/modules/calculator/data/datasources/crypto_remote_datasource.dart';
import 'package:crypto_challenge/modules/calculator/domain/abstractions/icrypto_repository.dart';
import 'package:crypto_challenge/modules/calculator/domain/models/coin_model.dart';
import 'package:crypto_challenge/modules/calculator/domain/models/price_model.dart';
import 'package:dartz/dartz.dart';

class CryptoRepository implements ICryptoRepository {
  CryptoRepository({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  final CryptoRemoteDatasource remoteDatasource;
  final CryptoLocalDatasource localDatasource;

  @override
  Future<Either<String, List<PriceModel>>> findPrices({
    required List<CoinModel> coins,
  }) async {
    final remoteResponse = await remoteDatasource.findPrices(coins: coins);
    if (remoteResponse is ApiResponseFail) {
      final message = (remoteResponse as ApiResponseFail).error.message;
      return Left(message);
    }
    return Right(remoteResponse.dataIfSuccess!);
  }

  @override
  Future<Either<String, List<CoinModel>>> findCoins() async {
    return await localDatasource.findCoins();
  }
}
