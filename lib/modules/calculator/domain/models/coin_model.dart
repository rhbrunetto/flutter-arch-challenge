import 'package:crypto_challenge/common/definitions/types.dart';

class CoinModel {
  CoinModel({
    required this.id,
    required this.name,
    required this.symbol,
  });

  final String id;
  final String name;
  final String symbol;

  factory CoinModel.fromJson(Json json) => CoinModel(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
      );
}
