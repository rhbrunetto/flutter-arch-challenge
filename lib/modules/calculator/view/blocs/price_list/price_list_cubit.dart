import 'package:bloc/bloc.dart';
import 'package:crypto_challenge/modules/calculator/domain/models/price_model.dart';
import 'package:crypto_challenge/modules/calculator/domain/usecases/coin_usecase.dart';
import 'package:crypto_challenge/modules/calculator/domain/usecases/price_usecase.dart';

part 'price_list_state.dart';

class PriceListCubit extends Cubit<PriceListState> {
  PriceListCubit({
    required this.coinUseCase,
    required this.priceUseCase,
  }) : super(PriceListInitial());

  final CoinUseCase coinUseCase;
  final PriceUseCase priceUseCase;

  Future<void> load() async {
    final coinResponse = await coinUseCase.find();
    coinResponse.fold(
      (error) => emit(PriceListFailed(message: error)),
      (coinList) async {
        final priceResponse = await priceUseCase.find(coinList);
        priceResponse.fold(
          (error) => emit(PriceListFailed(message: error)),
          (priceList) => emit(PriceListLoaded(prices: priceList)),
        );
      },
    );
  }
}
