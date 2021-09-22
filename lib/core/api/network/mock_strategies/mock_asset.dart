import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../network/mock_strategy.dart';

class MockAssetStrategy extends MockStrategy {
  MockAssetStrategy(
    this.filename, {
    this.responseDelay = const Duration(seconds: 0),
  });

  final String filename;
  final Duration responseDelay;

  @override
  Future<dynamic> get data async => await Future.delayed(responseDelay).then(
        (_) => rootBundle
            .loadString(filename)
            .then((jsonStr) => jsonDecode(jsonStr)),
      );
}
