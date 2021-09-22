import 'package:crypto_challenge/modules/calculator/view/blocs/price_list/price_list_cubit.dart';
import 'package:crypto_challenge/modules/calculator/view/widgets/list_fail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({Key? key}) : super(key: key);

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  late final PriceListCubit priceListCubit;

  @override
  void initState() {
    super.initState();
    priceListCubit = Modular.get<PriceListCubit>()..load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Coins')),
        body: BlocBuilder<PriceListCubit, PriceListState>(
          bloc: priceListCubit,
          builder: (context, state) {
            if (state is PriceListFailed) {
              return ListFailWidget(
                message: state.message,
                onRefresh: () => priceListCubit.load(),
              );
            }

            if (state is! PriceListLoaded) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final currencyFormatter = NumberFormat.currency(
              locale: 'en_US',
              symbol: 'USD ',
            );

            return RefreshIndicator(
              onRefresh: () async => await priceListCubit.load(true),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: state.prices.length,
                itemBuilder: (context, index) {
                  final price = state.prices.elementAt(index);
                  return ListTile(
                    title: Text(price.coinModel.name),
                    subtitle: Text(currencyFormatter.format(price.priceInUsd)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Modular.to.pushNamed(
                      'calculate',
                      arguments: price,
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
}
