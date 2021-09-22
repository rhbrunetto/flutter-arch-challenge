import '../../../../network/network_response.dart';
import 'package:dio/dio.dart';

abstract class IDioErrorParser {
  NetworkResponse build(DioError error);
}
