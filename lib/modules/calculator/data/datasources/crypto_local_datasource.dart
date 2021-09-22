import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:crypto_challenge/modules/calculator/domain/models/coin_model.dart';

class CryptoLocalDatasource {
  final _coinFile = 'assets/json/coins.json';

  Future<Either<String, List<CoinModel>>> findCoins() async {
    try {
      final rawData = await rootBundle
          .loadString(_coinFile)
          .then((jsonStr) => jsonDecode(jsonStr));
      final coinList =
          (rawData as List).map((json) => CoinModel.fromJson(json)).toList();
      return Right(coinList);
    } catch (err) {
      return const Left('Error while reading local coin list');
    }
  }
}
