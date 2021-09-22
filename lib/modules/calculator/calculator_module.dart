import 'package:crypto_challenge/modules/calculator/data/datasources/crypto_local_datasource.dart';
import 'package:crypto_challenge/modules/calculator/data/datasources/crypto_remote_datasource.dart';
import 'package:crypto_challenge/modules/calculator/data/repositories/crypto_repository.dart';
import 'package:crypto_challenge/modules/calculator/domain/abstractions/icrypto_repository.dart';
import 'package:crypto_challenge/modules/calculator/domain/usecases/calculator_usecase.dart';
import 'package:crypto_challenge/modules/calculator/domain/usecases/coin_usecase.dart';
import 'package:crypto_challenge/modules/calculator/domain/usecases/price_usecase.dart';
import 'package:crypto_challenge/modules/calculator/view/blocs/calculator/calculator_cubit.dart';
import 'package:crypto_challenge/modules/calculator/view/blocs/price_list/price_list_cubit.dart';
import 'package:crypto_challenge/modules/calculator/view/screens/calculator_screen.dart';
import 'package:crypto_challenge/modules/calculator/view/screens/coin_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CalculatorModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => CryptoLocalDatasource(),
        ),
        Bind.factory(
          (i) => CryptoRemoteDatasource(apiManager: i.get()),
        ),
        Bind.factory<ICryptoRepository>(
          (i) => CryptoRepository(
            localDatasource: i.get(),
            remoteDatasource: i.get(),
          ),
        ),
        Bind.factory(
          (i) => CoinUseCase(cryptoRepository: i.get()),
        ),
        Bind.factory(
          (i) => PriceUseCase(cryptoRepository: i.get()),
        ),
        Bind.singleton(
          (i) => PriceListCubit(
            priceUseCase: i.get(),
            coinUseCase: i.get(),
          ),
        ),
        Bind.factory(
          (i) => CalculatorUseCase(),
        ),
        Bind.factory(
          (i) => CalculatorCubit(calculatorUseCase: i.get()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => const CoinScreen(),
        ),
        ChildRoute(
          '/calculate',
          child: (_, args) => CalculatorScreen(
            priceModel: args.data,
          ),
        ),
      ];
}
