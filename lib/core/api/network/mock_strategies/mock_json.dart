import 'package:crypto_challenge/common/definitions/types.dart';
import '../../network/mock_strategy.dart';

class MockJsonStrategy extends MockStrategy {
  MockJsonStrategy(
    this._data, {
    this.responseDelay = const Duration(seconds: 0),
  });

  final dynamic _data;
  final Duration responseDelay;

  @override
  Future<dynamic> get data async =>
      await Future.delayed(responseDelay).then((_) => _data);

  factory MockJsonStrategy.emptyJson({
    Duration responseDelay = const Duration(seconds: 0),
  }) =>
      MockJsonStrategy(const <String, dynamic>{}, responseDelay: responseDelay);

  factory MockJsonStrategy.emptyJsonList({
    Duration responseDelay = const Duration(seconds: 0),
  }) =>
      MockJsonStrategy(const <Json>[], responseDelay: responseDelay);
}
