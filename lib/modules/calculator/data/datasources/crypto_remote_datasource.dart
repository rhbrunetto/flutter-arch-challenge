import 'package:crypto_challenge/core/api/api_manager.dart';
import 'package:crypto_challenge/core/api/api_response.dart';
import 'package:crypto_challenge/core/api/network/methods.dart';
import 'package:crypto_challenge/core/api/network/network_request.dart';
import 'package:crypto_challenge/modules/calculator/domain/models/coin_model.dart';
import 'package:crypto_challenge/modules/calculator/domain/models/price_model.dart';

class CryptoRemoteDatasource {
  CryptoRemoteDatasource({
    required this.apiManager,
  });

  final IApiManager apiManager;

  Future<ApiResponse<List<PriceModel>>> findPrices({
    required List<CoinModel> coins,
  }) async {
    final coinIds = coins.map((coin) => coin.id).join(',');
    const currencies = 'usd';

    return apiManager.apiRequest(
      NetworkRequest(
          endpoint: '/simple/price',
          method: const Get(),
          queryParameters: {
            'ids': coinIds,
            'vs_currencies': currencies,
          }),
      buildData: (data) => coins
          .map(
            (coin) => PriceModel(
              coinModel: coin,
              priceInUsd: double.tryParse(data[coin.id]['usd'].toString())!,
            ),
          )
          .toList(),
    );
  }
}
