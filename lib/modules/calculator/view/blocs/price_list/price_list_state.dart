part of 'price_list_cubit.dart';

abstract class PriceListState {}

class PriceListInitial extends PriceListState {}

class PriceListLoading extends PriceListState {}

class PriceListFailed extends PriceListState {
  PriceListFailed({
    required this.message,
  });

  final String message;
}

class PriceListLoaded extends PriceListState {
  PriceListLoaded({
    required this.prices,
  });

  List<PriceModel> prices;
}
