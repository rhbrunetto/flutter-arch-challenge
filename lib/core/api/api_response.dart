import './api_error.dart';

abstract class ApiResponse<T> {}

extension ApiResponseExtension<T> on ApiResponse<T> {
  bool get isSuccess => this is ApiResponseSuccess;

  T? get dataIfSuccess => isSuccess ? (this as ApiResponseSuccess).data : null;
}

class ApiResponseSuccess<T> implements ApiResponse<T> {
  final T? data;

  ApiResponseSuccess({this.data});
}

class ApiResponseFail<T> implements ApiResponse<T> {
  final ApiError error;

  ApiResponseFail({required this.error});
}
